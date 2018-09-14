//
//  User.swift
//  GitHubClient
//
//  Created by favre on 09/08/2018.
//  Copyright © 2018 mellonmellon. All rights reserved.
//

import Foundation


struct User: Codable {
  var login: String = ""
  var id: Int = -1
  var avatarUrlString: String = ""
  
  enum CodingKeys: String, CodingKey {
    case login = "login"
    case id = "id"
    case avatarUrlString = "avatar_url"
  }
}




