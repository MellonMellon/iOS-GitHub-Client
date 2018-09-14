//
//  LoginTextfieldView.swift
//  GitHubClient
//
//  Created by favre on 07/08/2018.
//  Copyright © 2018 mellonmellon. All rights reserved.
//

import UIKit

@IBDesignable
class LoginTextfieldView: UIView {

  
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
  
  @IBInspectable
  public var separatorColor: UIColor = .lightGray {
    didSet {
      self.separatorView.backgroundColor = separatorColor
    }
  }
  
  
  let loginTextfield = UITextField()
  let passwordTextfield = UITextField()
  let separatorView = UIView()
  
  var username: String {
    return loginTextfield.text ?? ""
  }
  
  var password: String {
    return passwordTextfield.text ?? ""
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    //xibSetup()
  }
  
  override func willMove(toSuperview newSuperview: UIView?) {
    super.willMove(toSuperview: newSuperview)
    setup()
    setupConstraints()
  }
  
  func setup() {
    loginTextfield.keyboardType = .default
    loginTextfield.placeholder = "Email"

    passwordTextfield.placeholder = "Password"
    passwordTextfield.isSecureTextEntry = true
   
    separatorView.backgroundColor = separatorColor
    
    addSubview(separatorView)
    addSubview(loginTextfield)
    addSubview(passwordTextfield)
  }
  
  func setupConstraints() {
    setupSeparatorView()
    setupLoginTextfield()
    setupPasswordTextfield()
  }
  
  func setupLoginTextfield() {
    loginTextfield.translatesAutoresizingMaskIntoConstraints = false
    let loginTop = loginTextfield.topAnchor.constraint(equalTo: topAnchor)
    let loginLeading = loginTextfield.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
    let loginTrailing = loginTextfield.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
    let loginBottom = loginTextfield.bottomAnchor.constraint(equalTo: separatorView.topAnchor)
    
    NSLayoutConstraint.activate([loginTop, loginLeading, loginTrailing, loginBottom])
  }
  
  func setupPasswordTextfield() {
    passwordTextfield.translatesAutoresizingMaskIntoConstraints = false
    let passwordTop = passwordTextfield.topAnchor.constraint(equalTo: separatorView.topAnchor)
    let passwordLeading = passwordTextfield.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
    let passwordTrailing = passwordTextfield.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
    let passwordBottom = passwordTextfield.bottomAnchor.constraint(equalTo: bottomAnchor)
    
    NSLayoutConstraint.activate([passwordTop, passwordLeading, passwordTrailing, passwordBottom])
  }
  
  
  func setupSeparatorView() {
    separatorView.translatesAutoresizingMaskIntoConstraints = false
    
    let separatorLeading = separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
    let separatorTrailing = separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
    let separatorCenterY = separatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
    let separatorHeight = separatorView.heightAnchor.constraint(equalToConstant: 1)
    
    NSLayoutConstraint.activate([separatorHeight, separatorLeading, separatorTrailing, separatorCenterY])
  }
  
  
  /*func xibSetup() {
    guard let view = loadViewFromNib() else { return }
    view.frame = bounds
    view.autoresizingMask =
      [.flexibleWidth, .flexibleHeight]
    addSubview(view)
    contentView = view
  }
  
  func loadViewFromNib() -> LoginTextfieldView? {
    let bundle = Bundle.main
    return bundle.loadNibNamed(nibName, owner: self, options: nil)?.first as? LoginTextfieldView
  }*/
  
  /*
   // Only override draw() if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   override func draw(_ rect: CGRect) {
   // Drawing code
   }
   */
  
  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    setup()
    setupConstraints()
   // xibSetup()
  }
  
}
