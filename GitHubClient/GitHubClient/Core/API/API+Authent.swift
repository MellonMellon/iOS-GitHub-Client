//
//  API+Authent.swift
//  GitHubClient
//
//  Created by favre on 09/08/2018.
//  Copyright © 2018 mellonmellon. All rights reserved.
//

import Foundation
//https://api.github.com

enum AuthentService: UrlConvertible {
  case basic(String)
  
  var version: String { return "" }
  
  var endPoint: String {
    switch self {
    case .basic:
      return ""
    }
  }
  
  var parameters:[String: Any] {
    switch self {
    case .basic:
      return [:]
    }
  }
  
  var headers: [String: String] {
    switch self {
    case .basic(let token):
      return [
        "Content-Type": "application/json",
        "Authorization": "Basic \(token)"
      ]
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .basic:
      return .get
    }
  }
}

//MARK: - Helper
extension HTTPSession {
  
  static func authent(username: String, password: String, completion: @escaping (Data?, Error?) -> Void) {
    
    let loginString = String(format: "%@:%@", username, password)
    let loginData = loginString.data(using: String.Encoding.utf8)!
    let base64LoginString = loginData.base64EncodedString()
    Store.token = "\(base64LoginString)"
    
    HTTPSession.request(urlConvertible: AuthentService.basic(Store.token), completion: completion)
  }
  
}

