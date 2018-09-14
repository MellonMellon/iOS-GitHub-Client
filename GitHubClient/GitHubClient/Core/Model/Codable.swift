//
//  Codable.swift
//  GitHubClient
//
//  Created by favre on 09/08/2018.
//  Copyright © 2018 mellonmellon. All rights reserved.
//

import Foundation


extension Data {
  
  func decode<T>(_ type: T.Type) throws -> T where T: Decodable{
    let jsonDecoder = JSONDecoder()
    return try jsonDecoder.decode(T.self, from: self)
  }
  
}
