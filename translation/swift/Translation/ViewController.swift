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
import googleapis

class ViewController: UIViewController {

  var appBar = MDCAppBar()
  // Text Field
  var inputTextField: MDCTextField = {
    let textField = MDCTextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()
  var  textFieldBottomConstraint: NSLayoutConstraint!
  let inputTextFieldController: MDCTextInputControllerOutlined
  var tableViewDataSource = [[String: String]]()
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var pickerView: UIPickerView!

  var sourceLanguageCode = ["hh", "mm", "ll", "eee", "fda"]//[String]()
  var targetLanguageCode = ["hhe", "mem", "lel", "eefe", "fdfa"]//[String]()

  lazy var alert : UIAlertController = {
    let alert = UIAlertController(title: ApplicationConstants.tokenFetchingAlertMessage, message: ApplicationConstants.tokenFetchingAlertMessage, preferredStyle: .alert)
    return alert
  }()

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
    self.title = ApplicationConstants.title
    setUpNavigationBarAndItems()
    registerKeyboardNotifications()
    setupPickerView()
    self.view.addSubview(inputTextField)
    inputTextField.backgroundColor = .white
    inputTextField.returnKeyType = .send
    inputTextFieldController.placeholderText = ApplicationConstants.queryTextFieldPlaceHolder
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

    let rightBarButton = UIBarButtonItem()
    rightBarButton.tintColor = ApplicationScheme.shared.colorScheme.primaryColorVariant
    rightBarButton.title = ApplicationConstants.glossaryButton
    rightBarButton.target = self
    rightBarButton.action = #selector(glossaryButtonTapped)
    appBar.navigationBar.rightBarButtonItem = rightBarButton
    MDCAppBarColorThemer.applySemanticColorScheme(ApplicationScheme.shared.colorScheme, to:self.appBar)
  }

  @objc func glossaryButtonTapped() {
    let glossaryStatus = UserDefaults.standard.bool(forKey: ApplicationConstants.glossaryStatus)
    let alertVC = UIAlertController(title: ApplicationConstants.glossaryAlertTitle, message: glossaryStatus ? ApplicationConstants.glossaryDisbleAlertMessage : ApplicationConstants.glossaryEnableAlertMessage, preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: glossaryStatus ? ApplicationConstants.glossaryAlerOKDisableTitle : ApplicationConstants.glossaryAlertOKEnableTitle, style: .default, handler: { (_) in
      UserDefaults.standard.set(!glossaryStatus, forKey: ApplicationConstants.glossaryStatus)
    }))

    alertVC.addAction(UIAlertAction(title: ApplicationConstants.glossaryAlertCacelTitle, style: .default))

    present(alertVC, animated: true)
  }
  
  @objc func presentNavigationDrawer() {
    // present picker view with languages

    TextToTranslationService.sharedInstance.getLanguageCodes { (supportedLanguages) in
      if supportedLanguages.languagesArray_Count > 0, let languages = supportedLanguages.languagesArray as? [SupportedLanguage] {
        self.sourceLanguageCode = languages.filter({return $0.supportSource }).map({ (supportedLanguage) -> String in
          return supportedLanguage.languageCode
        })
        self.targetLanguageCode = languages.filter({return $0.supportTarget }).map({ (supportedLanguage) -> String in
          return supportedLanguage.languageCode
        })
        self.presentPickerView()
      }
    }
  }

  func presentPickerView() {
    pickerView.isHidden = false
    view.bringSubviewToFront(pickerView)
    pickerView.reloadAllComponents()

  }

  func setupPickerView() {
    let toolBar = UIToolbar()
    toolBar.barStyle = UIBarStyle.default
    toolBar.isTranslucent = true
    toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
    toolBar.sizeToFit()

    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(pickerDoneButtonTapped))
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(pickerCancelButtonTapped))

    toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
    toolBar.isUserInteractionEnabled = true

    //pickerView.setValue(toolBar, forKey: "inputAccessoryView")
    inputTextField.inputAccessoryView = toolBar
    inputTextField.inputView = pickerView
  }

  @objc func pickerDoneButtonTapped() {
    pickerView.isHidden = true
    view.sendSubviewToBack(pickerView)
  }

  @objc func pickerCancelButtonTapped() {
    pickerView.isHidden = true
    view.sendSubviewToBack(pickerView)
  }


}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 2
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return max(sourceLanguageCode.count, targetLanguageCode.count)
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if component == 0 {
      return sourceLanguageCode.count > row ? sourceLanguageCode[row] : ""
    } else {
      return targetLanguageCode.count > row ? targetLanguageCode[row] : ""
    }
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
      textToTranslation(text: text)
      tableViewDataSource.append([ApplicationConstants.selfKey: text])
      tableView.insertRows(at: [IndexPath(row: tableViewDataSource.count - 1, section: 0)], with: .automatic)
    }

    textField.text = ""
    return true
  }

  //start sending text
  func textToTranslation(text: String) {
    TextToTranslationService.sharedInstance.textToSyntax(text: text, completionHandler:
      { (response) in
        //Handle success response
        var responseText = ""
        if response.glossaryTranslationsArray_Count > 0, let tResponse = response.glossaryTranslationsArray.firstObject as? Translation {
          responseText = tResponse.translatedText
        } else if response.translationsArray_Count > 0, let tResponse = response.translationsArray.firstObject as? Translation {
          responseText = tResponse.translatedText
        }

        if !responseText.isEmpty {
          self.tableViewDataSource.append([ApplicationConstants.botKey: responseText])
          self.tableView.insertRows(at: [IndexPath(row: self.tableViewDataSource.count - 1, section: 0)], with: .automatic)
          self.tableView.scrollToBottom()
        }
    })
  }
}

// MARK: Table delegate handling
extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableViewDataSource.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let data = tableViewDataSource[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: data[ApplicationConstants.selfKey] != nil ? "selfCI" : "intentCI", for: indexPath) as! ChatTableViewCell
    if data[ApplicationConstants.selfKey] != nil {
      cell.selfText.text = data[ApplicationConstants.selfKey]
    } else {
      cell.botResponseText.text = data[ApplicationConstants.botKey]
    }
    return cell
  }
}

extension UITableView {
  func  scrollToBottom(animated: Bool = true) {
    let sections = self.numberOfSections
    let rows = self.numberOfRows(inSection: sections - 1)
    if (rows > 0) {
      self.scrollToRow(at: NSIndexPath(row: rows - 1, section: sections - 1) as IndexPath, at: .bottom, animated: true)
    }
  }
}


