//
//  ViewController.swift
//  GitHubClient
//
//  Created by favre on 07/08/2018.
//  Copyright © 2018 mellonmellon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var  activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var validateButton: Button!
  @IBOutlet weak var loginView: LoginTextfieldView!
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var constraintContentHeight: NSLayoutConstraint!
  fileprivate var activeField: UITextField? = nil
  fileprivate var lastOffset: CGPoint = CGPoint.zero
  fileprivate var keyboardHeight: CGFloat? = nil
  
  var isActivityIndicatorHidden: Bool = true {
    didSet {
      validateButton.isHidden = !isActivityIndicatorHidden
      activityIndicator.isHidden = isActivityIndicatorHidden
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    loginView.loginTextfield.delegate = self
    loginView.passwordTextfield.delegate = self
    
    // Observe keyboard change
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    
    // Add touch gesture for contentView
    self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(returnTextView(gesture:))))

  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func goToFruit() {
    DispatchQueue.main.async {
      self.isActivityIndicatorHidden = true
      let storyboard = UIStoryboard(name: "Fruits", bundle: Bundle.main)
      if let firstViewController = storyboard.instantiateInitialViewController() {
        self.present(firstViewController, animated: true, completion: nil)
      }
    }
  }
  
  func presentError(_ error: Error) {
    DispatchQueue.main.async {
      self.showError(error: error)
      self.isActivityIndicatorHidden = true
    }
  }
  
  func validate() {
    guard !loginView.username.isEmpty && !loginView.password.isEmpty else {
      return
    }
    
    self.isActivityIndicatorHidden = false
    HTTPSession.authent(username: loginView.username, password: loginView.password) { data, error in
      if let error = error {
        self.presentError(error)
      } else {
        HTTPSession.currentUser { user, error in
          if let error = error {
            self.presentError(error)
          } else {
            Store.user = user
            self.goToFruit()
          }
        }
      }
    }
  }
  
  @IBAction func validateAction(_ sender: Any) {
    self.validate()
  }
  
  
  @objc func keyboardWillShow(notification: NSNotification) {
    if keyboardHeight != nil {
      return
    }
    if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
      keyboardHeight = keyboardSize.height
      // so increase contentView's height by keyboard height
      UIView.animate(withDuration: 0.3, animations: {
        self.constraintContentHeight.constant += self.keyboardHeight ?? 0
      })
      // move if keyboard hide input field
      let distanceToBottom = self.scrollView.frame.size.height - (activeField?.frame.origin.y)! - (activeField?.frame.size.height)!
      let collapseSpace = keyboardHeight ?? 0 - distanceToBottom
      if collapseSpace < 0 {
        // no collapse
        return
      }
      // set new offset for scroll view
      UIView.animate(withDuration: 0.3, animations: {
        // scroll to the position above keyboard 10 points
        self.scrollView.contentOffset = CGPoint(x: self.lastOffset.x, y: collapseSpace + 10)
      })
    }
  }
  
  @objc func keyboardWillHide(notification: NSNotification) {
    UIView.animate(withDuration: 0.3) {
      self.constraintContentHeight.constant -= self.keyboardHeight ?? 0
      self.scrollView.contentOffset = self.lastOffset
    }
    keyboardHeight = nil
  }
  
  @objc func returnTextView(gesture: UIGestureRecognizer) {
    guard activeField != nil else {
      return
    }
    
    activeField?.resignFirstResponder()
    activeField = nil
  }
  
}

//MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    activeField = textField
    lastOffset = self.scrollView.contentOffset
    return true
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    activeField?.resignFirstResponder()
    activeField = nil
    return true
  }
}
