//
//  API+Authent.swift
//  GitHubClient
//
//  Created by favre on 09/08/2018.
//  Copyright © 2018 mellonmellon. All rights reserved.
//

import Foundation
//https://api.github.com

enum UserService: UrlConvertible {
  case current
  
  var version: String { return "" }
  
  var endPoint: String {
    switch self {
    case .current:
      return "/user"
    }
  }
  
  var parameters:[String: Any] {
    switch self {
    case .current:
      return [:]
    }
  }
  
  var headers: [String: String] {
    switch self {
    case .current:
      return [
        "Content-Type": "application/json",
        "Authorization": "Basic \(Store.token)"
      ]
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .current:
      return .get
    }
  }
}

//MARK: - Helper
extension HTTPSession {
  
  static func currentUser(completion: @escaping (User?, Error?) -> Void) {
    
    HTTPSession.request(urlConvertible: UserService.current) { data, error in
      if let error = error {
        completion(nil, error)
      } else {
        do {
          let user = try data?.decode(User.self) ?? nil
          completion(user, nil)
        } catch let error {
          completion(nil, error)
        }
      }
    }
  
  }
}
