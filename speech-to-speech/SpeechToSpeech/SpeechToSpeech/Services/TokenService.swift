//
//  SpeechToSpeechService.swift
//  Speech
//
//  Created by Santhosh Kumar Vaddi on 4/11/19.
//  Copyright © 2019 Google. All rights reserved.
//

import Foundation
import googleapis
import AuthLibrary

class TokenService {
    
    static let shared = TokenService()
    var token : String?
    
    func fetchToken(_ completion:@escaping (ServiceError?)->()) {
        
        let credentialsURL = Bundle.main.url(forResource: "credentials", withExtension: "json")!
        let scopes = ["https://www.googleapis.com/auth/cloud-platform"]
        let provider = ServiceAccountTokenProvider(credentialsURL:credentialsURL, scopes:scopes)
        if let provider = provider {
            try! provider.withToken({ (token, error) in
                if let token = token {
                    self.token = token.AccessToken
                    completion(nil)
                } else {
                    completion(.tokenNotAvailable)
                }
            })
        } else {
            completion(.invalidCredentials)
        }
    }
}
