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

import Foundation
import googleapis
import AVFoundation
import AuthLibrary
import Firebase

class TextToTranslationService {
  private var client : TranslationService = TranslationService(host: ApplicationConstants.Host)
  private var writer : GRXBufferedPipe = GRXBufferedPipe()
  private var call : GRPCProtoCall!
  static let sharedInstance = TextToTranslationService()
  var authToken: String = ""
  
  private var session : String {
    return "projects/" + ApplicationConstants.projectID + "/agent/sessions/" + ApplicationConstants.SessionID
  }
  
  func getDeviceID(callBack: @escaping (String)->Void) {
    InstanceID.instanceID().instanceID { (result, error) in
      if let error = error {
        print("Error fetching remote instance ID: \(error)")
        callBack( "")
      } else if let result = result {
        print("Remove instance ID token: \(result.token)")
        callBack( result.token)
      } else {
        callBack( "")
      }
    }
  }
  
  func textToSyntax(text:String, completionHandler: @escaping (_ response: TranslateTextResponse) -> Void) {
    
    let translateText = TranslateTextRequest()
    translateText.contentsArray = [text]
    translateText.mimeType = ApplicationConstants.mimeType
    translateText.sourceLanguageCode = "en-US"
    translateText.targetLanguageCode = "es"
    translateText.parent = "projects/\(ApplicationConstants.projectID)"
    
    let glossaryStatus = UserDefaults.standard.bool(forKey: ApplicationConstants.glossaryStatus)
    if glossaryStatus {
      let glossaryConfig = TranslateTextGlossaryConfig()
      glossaryConfig.glossary = "projects/\(ApplicationConstants.projectID)/glossaries/\(ApplicationConstants.glossaryID)"
    }
    
    call = client.rpcToTranslateText(with: translateText) { (translateTextResponse, error) in
      if error != nil {
        print(error?.localizedDescription ?? "No error description available")
        return
      }
      guard let response = translateTextResponse else {
        print("No response received")
        return
      }
      print("translateTextResponse\(response)")
      completionHandler(response)
    }
    self.call.requestHeaders.setObject(NSString(string:authToken),
                                       forKey:NSString(string:"Authorization"))
    
    self.call.requestHeaders.setObject(NSString(string:Bundle.main.bundleIdentifier!), forKey:NSString(string:"X-Ios-Bundle-Identifier"))
    call.start()
  }

  func getLanguageCodes(completionHandler: @escaping (_ response: SupportedLanguages) -> Void) {
    let langRequest = GetSupportedLanguagesRequest()
    langRequest.parent = "projects/\(ApplicationConstants.projectID)"
    call = client.rpcToGetSupportedLanguages(with: langRequest, handler: { (supportedLanguagesResponse, error) in
      if error != nil {
        print(error?.localizedDescription ?? "No error description available")
        return
      }
      guard let response = supportedLanguagesResponse else {
        print("No response received")
        return
      }
      print("supportedLanguagesResponse\(response)")
      completionHandler(response)
    })
    self.call.requestHeaders.setObject(NSString(string:authToken),
                                       forKey:NSString(string:"Authorization"))

    self.call.requestHeaders.setObject(NSString(string:Bundle.main.bundleIdentifier!), forKey:NSString(string:"X-Ios-Bundle-Identifier"))
    call.start()
  }

}




