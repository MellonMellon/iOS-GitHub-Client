//
//  Fruit.swift
//  GitHubClient
//
//  Created by favre on 08/08/2018.
//  Copyright © 2018 mellonmellon. All rights reserved.
//

import Foundation

struct Fruit {
  var id: String = ""
  var name: String = ""
  var imageName: String = ""
  
  init(name: String) {
    self.id = UUID().uuidString
    self.name = name
    self.imageName = name
  }
}
