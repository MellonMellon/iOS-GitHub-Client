//
//  Button.swift
//  GitHubClient
//
//  Created by favre on 07/08/2018.
//  Copyright © 2018 mellonmellon. All rights reserved.
//

import UIKit

@IBDesignable
class Button: UIButton {

  @IBInspectable
  public var cornerRadius: CGFloat = 0.0 {
    didSet {
      self.layer.cornerRadius = self.cornerRadius
    }
  }
  
  @IBInspectable
  public var borderWidth: CGFloat = 0.0 {
    didSet {
      self.layer.borderWidth = self.borderWidth
    }
  }
  
  @IBInspectable
  public var borderColor: UIColor = .clear {
    didSet {
      self.layer.borderColor = self.borderColor.cgColor
    }
  }
}
