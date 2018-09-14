//
//  ViewController+Util.swift
//  GitHubClient
//
//  Created by favre on 09/08/2018.
//  Copyright © 2018 mellonmellon. All rights reserved.
//

import UIKit

extension UIViewController {
  
  func showError(error: Error?) {
    let alertController = UIAlertController(
      title: "Oops",
      message: error?.localizedDescription ?? "une erreur inconnue est survenue",
      preferredStyle: .alert)
    
    alertController.addAction(UIAlertAction(title: "Ok", style: .default) {
      [unowned alertController]  alertAction in
      alertController.dismiss(animated: true, completion: nil)
    })
    
    self.present(alertController, animated: true, completion: nil)
  }
  
}
