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
import googleapis

extension Entity_Type {
  func getEntityType() -> String {
    switch self {
    case .gpbUnrecognizedEnumeratorValue, .unknown:
      return "NA"
    case .person:
      return "PERSON"
    case .location:
      return "LOCATION"
    case .organization:
      return "ORGANIZATION"
    case .event:
      return "EVENT"
    case .workOfArt:
      return "WORK OF ART"
    case .consumerGood:
      return "COSUMER GOOD"
    case .other:
      return "OTHER"
    @unknown default:
      return "NA"
    }
  }
}

class EntityTableViewCell: UITableViewCell {
  @IBOutlet weak var entityNameLabel: UILabel!
  @IBOutlet weak var entityTypeLabel: UILabel!
  @IBOutlet weak var entityURLLeftLabel: UILabel!
  @IBOutlet weak var entityURLRightLabel: UILabel!
  @IBOutlet weak var entitySalienceLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  func configureWith(entity: Entity) {
    entityNameLabel.text = entity.name
    entityTypeLabel.text = entity.type.getEntityType()
    if let metaData = entity.metadata as? Dictionary<String, Any>, let wikiURL = metaData["wikipedia_url"] as? String {
      entityURLRightLabel.text = wikiURL
    }
    entitySalienceLabel.text = "\(entity.salience)"
  }

}

class SentimentTableViewCell: UITableViewCell {
  @IBOutlet weak var sentenceLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var magnitudeLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  func configureWith(sentence: Sentence) {
    sentenceLabel.text = sentence.hasText ? (sentence.hasSentiment ? "Sentence: " +  sentence.text.content : sentence.text.content) : ""
    scoreLabel.text = sentence.hasSentiment ? "Score: \(sentence.sentiment.score)" : ""
    magnitudeLabel.text = sentence.hasSentiment ? "Magnitude: \(sentence.sentiment.magnitude)" : ""
  }
}
