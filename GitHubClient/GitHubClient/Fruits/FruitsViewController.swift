//
//  FruitsViewController.swift
//  GitHubClient
//
//  Created by favre on 08/08/2018.
//  Copyright © 2018 mellonmellon. All rights reserved.
//

import UIKit

class FruitsViewController: UITableViewController {
  
  enum FruitSegue: String {
    case edit = "editFruitSegue"
  }
  
  var selectedFruit: Fruit? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.tableView.reloadData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == FruitSegue.edit.rawValue {
      guard
        let navigationViewController = segue.destination as? UINavigationController,
        let viewController = navigationViewController.viewControllers.first as? EditFruitViewController
        else { return }
      
      viewController.fruit = self.selectedFruit
      self.selectedFruit = nil
    }
  }
  
  @IBAction func addAction(_ sender: Any) {
  self.performSegue(withIdentifier: FruitSegue.edit.rawValue, sender: self)
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   self.selectedFruit = Store.fruits[indexPath.row]
    self.performSegue(withIdentifier: FruitSegue.edit.rawValue, sender: self)
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if (editingStyle == UITableViewCellEditingStyle.delete) {
      Store.fruits.remove(at: indexPath.row)
      self.tableView.reloadData()
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return  Store.fruits.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "fruitCell", for: indexPath)
    let fruit = Store.fruits[indexPath.row]
    
    cell.textLabel?.text = fruit.name
    cell.imageView?.image = UIImage(named: fruit.imageName)
    
    return cell
  }
}

