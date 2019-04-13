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
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialTypographyScheme

class SettingsViewController: UIViewController {
  
  var colorScheme = MDCSemanticColorScheme()
  var typographyScheme = MDCTypographyScheme()
  var translateFromArray: [String] = {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let voiceList = appDelegate.voiceLists else { return [] }
    let from = voiceList.map { (formattedVoice) -> String in
      return formattedVoice.languageName
    }
    return from
  }()
  
  var translateToArray: [String] = {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let voiceList = appDelegate.voiceLists else { return [] }
    let to = voiceList.map { (formattedVoice) -> String in
      return formattedVoice.languageName
    }
    return to
  }()
  
  
  
  var selectedTransFrom = ""
  var selectedTransTo = ""
  var selectedSynthName = ""
  var selectedVoiceType = ""
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  func getSynthName() -> [String] {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let voiceList = appDelegate.voiceLists else { return [] }
    let synthName = voiceList.filter {
      return $0.languageName == selectedTransTo
    }
    if let synthesis = synthName.first {
      return synthesis.synthesisName
    }
    return []
  }
  
  func getVoiceType() -> [String] {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let voiceList = appDelegate.voiceLists else { return [] }
    let synthName = voiceList.filter {
      return $0.languageName == selectedTransTo
    }
    if let synthesis = synthName.first {
      return synthesis.synthesisGender
    }
    return []
  }
  
  @IBAction func translateFromAction(_ sender: Any) {
    let  actionSheet = SettingsViewController.thirtyOptions(completionHandler: {action in
      self.selectedTransFrom = action.title
    })
    present(actionSheet, animated: true, completion: nil)
  }
  
  @IBAction func translateTo(_ sender: Any) {
    
  }
  @IBAction func voiceType(_ sender: Any) {
    
  }
  
  
  @IBAction func synthesisName(_ sender: Any) {
  }
  
  @IBAction func getStarted(_ sender: Any) {
    
  }
  
  static func thirtyOptions(completionHandler: @escaping (MDCActionSheetAction) -> Void) -> MDCActionSheetController {
    let actionSheet = MDCActionSheetController(title: "Action sheet", message: "messageString")
    for i in 1...30 {
      let action = MDCActionSheetAction(title: "Action \(i)",
        image: #imageLiteral(resourceName: "CancelButton"),
        handler: completionHandler)
      actionSheet.addAction(action)
    }
    return actionSheet
  }
  
}
