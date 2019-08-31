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
  static let API_KEY = "YOUR API_KEY"
  static let Host = "language.googleapis.com"
  static let languageCode = "en-US"
}

extension ApplicationConstants {
  static let queryTextFieldPlaceHolder = "Type your input"
  static let menuItemChangedNotification = "menuItemChangedNotification"
}

//MARK: Bottom drawer
extension ApplicationConstants {
  static let selectedMenuItems = "selected Menu Items"
  static let sentimentAnalysis = "Sentiment"
  static let syntaxAnalysis = "Syntax"
  static let entityAnalysis = "Entity"
  static let category = "Category"
  static let tableViewCellID = "Cell"
  static let menuDrawerTitle = "Tap to enable other analysis for your text"
}

extension ApplicationConstants {
  static let moreButtonTitle = "Menu"
  static let sentimentScore = "Sentiment Score:"
  static let sentimentMagnitude = "Sentiment magnitude:"
}
