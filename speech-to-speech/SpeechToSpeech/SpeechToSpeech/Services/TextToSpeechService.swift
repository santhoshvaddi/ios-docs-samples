//
// Copyright 2019 Google Inc. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License")
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


class TextToSpeechRecognitionService {
  var client = TextToSpeech(host: ApplicationConstants.TTS_Host)
  private var writer = GRXBufferedPipe()
  private var call : GRPCProtoCall!
  
  static let sharedInstance = TextToSpeechRecognitionService()
  
  func textToSpeech(text:String, completionHandler: @escaping (_ audioData: Data) -> Void) {
    let synthesisInput = SynthesisInput()
    synthesisInput.text = text
    
    let voiceSelectionParams = VoiceSelectionParams()
    voiceSelectionParams.languageCode = "en-US"
    voiceSelectionParams.ssmlGender = SsmlVoiceGender.neutral
    
    let audioConfig = AudioConfig()
    audioConfig.audioEncoding = AudioEncoding.mp3
    
    let speechRequest = SynthesizeSpeechRequest()
    speechRequest.audioConfig = audioConfig
    speechRequest.input = synthesisInput
    speechRequest.voice = voiceSelectionParams
    
    call = client.rpcToSynthesizeSpeech(with: speechRequest, handler: { (synthesizeSpeechResponse, error) in
      if error != nil {
        print(error?.localizedDescription ?? "No error description available")
        return
      }
      guard let response = synthesizeSpeechResponse else {
        print("No response received")
        return
      }
      print("Text to speech response\(response)")
      guard let audioData =  response.audioContent else {
        print("no audio data received")
        return
      }
      completionHandler(audioData)
    })
    call.requestHeaders.setObject(NSString(string: ApplicationConstants.API_KEY), forKey:NSString(string:"X-Goog-Api-Key"))
    
    // if the API key has a bundle ID restriction, specify the bundle ID like this
    
    call.requestHeaders.setObject(NSString(string:Bundle.main.bundleIdentifier!), forKey:NSString(string:"X-Ios-Bundle-Identifier"))
    print("HEADERS:\(String(describing: call.requestHeaders))")
    call.start()
  }
    
    func getVoiceLists(completionHandler: @escaping ([FormattedVoice]) -> Void) {
        call = client.rpcToListVoices(with: ListVoicesRequest(), handler: { (listVoiceResponse, error) in
            print(listVoiceResponse ?? "No voice list found")
            if let listVoiceResponse = listVoiceResponse {
                let formattedVoice = FormattedVoice.formatVoiceResponse(listVoiceResponse: listVoiceResponse)
                print("Formatted output: \(formattedVoice)")
                completionHandler(formattedVoice)
            }
           
        })
        
        call.requestHeaders.setObject(NSString(string: ApplicationConstants.API_KEY), forKey:NSString(string:"X-Goog-Api-Key"))
        
        // if the API key has a bundle ID restriction, specify the bundle ID like this
        
        call.requestHeaders.setObject(NSString(string:Bundle.main.bundleIdentifier!), forKey:NSString(string:"X-Ios-Bundle-Identifier"))
        print("HEADERS:\(String(describing: call.requestHeaders))")
        call.start()
    
    }
    
    
}

struct FormattedVoice {
    var languageCode: String = ""
    var languageName: String = ""
    var synthesisName: [String] = []
    var synthesisGender: [String] = []
    
    static func formatVoiceResponse(listVoiceResponse: ListVoicesResponse) -> [FormattedVoice] {
        var result = [FormattedVoice]()
        for voice in listVoiceResponse.voicesArray {
            if let voice = voice as? Voice {
                for languageCode in voice.languageCodesArray {
                    let index = result.filter({$0.languageCode == ((languageCode as? String) ?? "")})
                    var resultVoice = index.count > 0 ? (index.first ?? FormattedVoice()) : FormattedVoice()
                    resultVoice.languageCode = (languageCode as? String) ?? ""
                    resultVoice.languageName = convertLanguageCodes(languageCode: resultVoice.languageCode)
                    
                    let name = getSynthesisName(name: voice.name)
                    if !resultVoice.synthesisName.contains(name) {
                        resultVoice.synthesisName.append(getSynthesisName(name: voice.name))
                    }
                    
                    let gender = getGender(name: voice.name, gender: voice.ssmlGender)
                    if !resultVoice.synthesisGender.contains(gender) {
                        resultVoice.synthesisGender.append(gender)
                    }
                    if index.count > 0 {
                        result.removeAll(where: {$0.languageCode == ((languageCode as? String) ?? "")})
                    }
                    result.append(resultVoice)
                }
            }
        }
        return result
    }
    
    static func convertLanguageCodes(languageCode: String) -> String {
        var languageName = ""
        switch (languageCode) {
        case "da-DK":
            languageName = "Danish"
        case "de-DE":
            languageName = "German"
        case "en-AU":
            languageName = "English (Australia)"
        case "en-GB":
            languageName = "English (United Kingdom)"
        case "en-US":
            languageName = "English (United States)"
        case "es-ES":
            languageName = "Spanish"
        case "fr-CA":
            languageName = "French (Canada)"
        case "fr-FR":
            languageName = "French"
        case "it-IT":
            languageName = "Italian"
        case "ja-JP":
            languageName = "Japanese"
        case "ko-KR":
            languageName = "Korean"
        case "nl-NL":
            languageName = "Dutch"
        case "nb-NO":
            languageName = "Norwegian"
        case "pl-PL":
            languageName = "Polish"
        case "pt-BR":
            languageName = "Portugese (Brazil)"
            
        case "pt-PT":
            languageName = "Portugese"
            
        case "ru-RU":
            languageName = "Russian"
            
        case "sk-SK":
            languageName = "Slovak (Slovakia)"
            
        case "sv-SE":
            languageName = "Swedish"
            
        case "tr-TR":
            languageName = "Turkish"
            
        case "uk-UA":
            languageName = "Ukrainian (Ukraine)"
            
        default:
            languageName = languageCode
        }
        return languageName
    }
    
    static func getSynthesisName(name: String) -> String {
        let components = name.components(separatedBy: "-")
        if components.count > 2 {
            return components[2]
        }
        return ""
    }
    
    static func getGender(name: String, gender: SsmlVoiceGender) -> String {
        let components = name.components(separatedBy: "-")
        if components.count > 3 {
            return gender.getGenderString() + " " + components[3]
        }
        return gender.getGenderString()
    }
}

extension SsmlVoiceGender {
    func getGenderString() -> String {
        switch self {
        case .gpbUnrecognizedEnumeratorValue:
            return "Unspecified"
        case .ssmlVoiceGenderUnspecified:
            return "Unspecified"
        case .male:
            return "Male"
        case .female:
            return "Female"
        case .neutral:
            return "Neutral"
        }
    }
}


