//
// Copyright 2019 Google Inc. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import UIKit
import MaterialComponents

class ViewController: UIViewController {

  @IBOutlet weak var TextLabel: UILabel!
  var appBar = MDCAppBar()
  // Text Field
  var inputTextField: MDCTextField = {
    let textField = MDCTextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()
  var  textFieldBottomConstraint: NSLayoutConstraint!
  let inputTextFieldController: MDCTextInputControllerOutlined
  let headerViewController = DrawerHeaderViewController()
  let contentViewController = DrawerContentViewController()


  //init with nib name
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    inputTextFieldController = MDCTextInputControllerOutlined(textInput: inputTextField)
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    inputTextFieldController.placeholderText = ApplicationConstants.queryTextFieldPlaceHolder
  }

  //init with coder
  required init?(coder aDecoder: NSCoder) {
    inputTextFieldController = MDCTextInputControllerOutlined(textInput: inputTextField)
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.tintColor = .black
    self.view.backgroundColor = ApplicationScheme.shared.colorScheme.surfaceColor

    updateNavigationTitle()
    NotificationCenter.default.addObserver(self, selector: #selector(updateNavigationTitle), name: NSNotification.Name(rawValue: ApplicationConstants.menuItemChangedNotification), object: nil)
    setUpNavigationBarAndItems()
    registerKeyboardNotifications()
    self.view.addSubview(inputTextField)
    inputTextField.backgroundColor = .white
    inputTextField.returnKeyType = .send
    inputTextFieldController.placeholderText = "Type your input"
    inputTextField.delegate = self

    // Constraints
    textFieldBottomConstraint = NSLayoutConstraint(item: inputTextField,
                                                   attribute: .bottom,
                                                   relatedBy: .equal,
                                                   toItem: view,
                                                   attribute: .bottom,
                                                   multiplier: 1,
                                                   constant: 0)

    var constraints = [NSLayoutConstraint]()
    constraints.append(textFieldBottomConstraint)
    constraints.append(contentsOf:
      NSLayoutConstraint.constraints(withVisualFormat: "H:|-[intentTF]-|",
                                     options: [],
                                     metrics: nil,
                                     views: [ "intentTF" : inputTextField]))
    NSLayoutConstraint.activate(constraints)
    let colorScheme = ApplicationScheme.shared.colorScheme
    MDCTextFieldColorThemer.applySemanticColorScheme(colorScheme,
                                                     to: self.inputTextFieldController)
  }

  @IBAction func dismissKeyboardAction(_ sender:Any) {
    inputTextField.resignFirstResponder()
  }

  @objc func updateNavigationTitle() {
    let defaults = UserDefaults.standard
    if let defaultItems = defaults.value(forKey: ApplicationConstants.selectedMenuItems) as? Int {
      title = BetaFeatureMenu(rawValue: defaultItems)?.stringValue()
    } else {
      self.title = BetaFeatureMenu.entityAnalysis.stringValue()
    }
  }

  func setUpNavigationBarAndItems() {
    //Initialize and add AppBar
    self.addChild(appBar.headerViewController)
    appBar.addSubviewsToParent()
    let barButtonLeadingItem = UIBarButtonItem()
    barButtonLeadingItem.tintColor = ApplicationScheme.shared.colorScheme.primaryColorVariant
    barButtonLeadingItem.title = ApplicationConstants.moreButtonTitle
    barButtonLeadingItem.target = self
    barButtonLeadingItem.action = #selector(presentNavigationDrawer)
    appBar.navigationBar.backItem = barButtonLeadingItem
    MDCAppBarColorThemer.applySemanticColorScheme(ApplicationScheme.shared.colorScheme, to:self.appBar)
  }

  @objc func presentNavigationDrawer() {
    let bottomDrawerViewController = MDCBottomDrawerViewController()
    bottomDrawerViewController.setTopCornersRadius(24, for: .collapsed)
    bottomDrawerViewController.setTopCornersRadius(8, for: .expanded)
    bottomDrawerViewController.isTopHandleHidden = false
    bottomDrawerViewController.topHandleColor = UIColor.lightGray
    bottomDrawerViewController.contentViewController = contentViewController
    bottomDrawerViewController.headerViewController = headerViewController
    bottomDrawerViewController.delegate = self
    MDCBottomDrawerColorThemer.applySemanticColorScheme(MDCSemanticColorScheme(),
                                                        toBottomDrawer: bottomDrawerViewController)
    present(bottomDrawerViewController, animated: true, completion: nil)
  }

  func bottomDrawerControllerDidChangeTopInset(_ controller: MDCBottomDrawerViewController,
                                               topInset: CGFloat) {
    headerViewController.titleLabel.center =
      CGPoint(x: headerViewController.view.frame.size.width / 2,
              y: (headerViewController.view.frame.size.height + topInset) / 2)
  }
}

extension ViewController: MDCBottomDrawerViewControllerDelegate {

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Navigation Drawer", "Bottom Drawer"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}

// MARK: - Keyboard Handling
extension ViewController {

  func registerKeyboardNotifications() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(self.keyboardWillShow),
      name: UIResponder.keyboardDidShowNotification,
      object: nil)

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(self.keyboardWillHide),
      name: UIResponder.keyboardWillHideNotification,
      object: nil)
  }

  @objc func keyboardWillShow(notification: NSNotification) {
    let keyboardFrame =
      (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    textFieldBottomConstraint.constant = -keyboardFrame.height

  }

  @objc func keyboardWillHide(notification: NSNotification) {
    textFieldBottomConstraint.constant = 0

  }
}


//MARK: Textfield delegate
extension ViewController: UITextFieldDelegate {
  //Captures the query typed by user
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    if let text = textField.text, text.count > 0 {
      sendTexttoAnalysis(text: text)
      textField.text = ""
      TextLabel.text = text
    }

    return true
  }

  //start sending text

  func sendTexttoAnalysis(text: String) {
    let defaults = UserDefaults.standard
    if let defaultItems = defaults.value(forKey: ApplicationConstants.selectedMenuItems) as? Int, let selectedAnalysis = BetaFeatureMenu(rawValue: defaultItems) {
      switch selectedAnalysis {
      case .entityAnalysis:
        textToEntityAnalysis(text: text)
      case .sentimentAnalysis:
        textToSentimentAnalysis(text: text)
      case .syntaxAnalysis:
        textToSyntaxAnalysis(text: text)
      case .category:
        textToClassifyCategory(text: text)
      }
    }
  }
  func textToSentimentAnalysis(text: String) {
    TextToSpeechRecognitionService.sharedInstance.textToSentiment(text: text, completionHandler:
      { (response) in
        //Handle success response
    })
  }

  func textToEntityAnalysis(text: String) {
    TextToSpeechRecognitionService.sharedInstance.textToEntity(text: text, completionHandler:
      { (response) in
        //Handle success response
    })
  }

  func textToSyntaxAnalysis(text: String) {
    TextToSpeechRecognitionService.sharedInstance.textToSyntax(text: text, completionHandler:
      { (response) in
        //Handle success response
    })
  }

  func textToClassifyCategory(text: String) {
    TextToSpeechRecognitionService.sharedInstance.textToCategory(text: text, completionHandler:
      { (response) in
        //Handle success response
    })
  }
}



