//
//  Store.swift
//  GitHubClient
//
//  Created by favre on 08/08/2018.
//  Copyright © 2018 mellonmellon. All rights reserved.
//

import Foundation


class Store {
  
  static var fruits: [Fruit] = [
    Fruit(name: "melon"),
    Fruit(name: "grapes"),
    Fruit(name: "plum"),
    Fruit(name: "coconut"),
    Fruit(name: "lemon"),
    Fruit(name: "banana"),
    Fruit(name: "strawberry"),
    Fruit(name: "orange"),
    ]
  
  static var token: String = ""
  static var user: User? = nil
  
}
