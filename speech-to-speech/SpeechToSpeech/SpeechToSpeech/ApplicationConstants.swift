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

//MARK: Stopwatch service
struct ApplicationConstants {
  static let API_KEY = "YOUR_API_KEY"
  static let TTS_Host = "texttospeech.googleapis.com"
  static let languageCode = "en-US"
  static let STT_Host = "speech.googleapis.com"
  static let TRANSLATE_Host = "translation.googleapis.com"

}

extension ApplicationConstants {
  static let ttsScreenTitle = "Speech-to-Speech Translation"
  static let SpeechScreenTitle = "Speech"
  static let selfKey = "Self"
  static let botKey = "Bot"
}

