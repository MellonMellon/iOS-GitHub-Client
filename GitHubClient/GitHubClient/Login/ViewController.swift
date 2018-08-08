//
//  ViewController.swift
//  GitHubClient
//
//  Created by favre on 07/08/2018.
//  Copyright © 2018 mellonmellon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func goToFruit() {
    let storyboard = UIStoryboard(name: "Fruits", bundle: Bundle.main)
    if let firstViewController = storyboard.instantiateInitialViewController() {
      self.present(firstViewController, animated: true, completion: nil)
    }
  }

  @IBAction func validateAction(_ sender: Any) {
    self.goToFruit()
  }
}

