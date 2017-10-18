//
//  MenuViewController.swift
//  FBSearch
//
//  Created by Matheos Asfaw on 4/12/17.
//  Copyright © 2017 MADesign. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var menuNameArrSec1 : Array = [String]()
    var menuNameArrSec2 : Array = [String]()
    var menuNameArrSec3 : Array = [String]()
    var iconImagesSec1 : Array = [UIImage]()
    var iconImagesSec2 : Array = [UIImage]()
   
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        menuNameArrSec1 = ["FB Search"]
        menuNameArrSec2 = ["Home", "Favorites"]
        menuNameArrSec3 = ["About Me"]
        
        iconImagesSec1 = [UIImage(named:"fb")!]
        iconImagesSec2 = [UIImage(named:"home")!, UIImage(named:"favorite")!]
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0 ){
          return  menuNameArrSec1.count
        }
        else if section == 1 {
            return menuNameArrSec2.count
        }
        else{
           return menuNameArrSec3.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        
        if (indexPath.section == 0 ){
            cell.textLabel?.removeFromSuperview()
            cell.lblMenuName?.text = menuNameArrSec1[indexPath.row]
            cell.imageIcon.image = iconImagesSec1[indexPath.row]
        }
        else if (indexPath.section == 1 ){
            cell.textLabel?.removeFromSuperview()
            cell.lblMenuName?.text = menuNameArrSec2[indexPath.row]
            cell.imageIcon.image = iconImagesSec2[indexPath.row]

        }
        else if (indexPath.section == 2 ){
            
            //cell.lblMenuName?.removeFromSuperview()
            cell.imageIcon?.removeFromSuperview()
            cell.lblMenuName?.text = menuNameArrSec3[indexPath.row]
            

        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let revealViewController:SWRevealViewController = self.revealViewController()
        
        let cell:MenuTableViewCell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
        
        
        if cell.lblMenuName.text! == "Home" {
        
            let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "FBSearchViewController") as! FBSearchViewController
            
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
            
        
        }
        
        if cell.lblMenuName.text! == "FB Search" {
            
            let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "FBSearchViewController") as! FBSearchViewController
            
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
            
            
        }
        
        if cell.lblMenuName.text == "About Me" {
           // print ("i am in the about me section")
            
            let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "AboutMeViewController") as! AboutMeViewController
            
            self.present(desController, animated: false, completion: nil)
            
//            let newFrontViewController = UINavigationController.init(rootViewController:desController)
//            
//            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
            
            
        }
        
        if cell.lblMenuName.text == "Favorites" {
           // print ("i am in the Favorites section")
            
            let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "FavoritesTabBarController")
            
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
            
            
        }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "MENU"
        }
        else if section == 2 {
            return "OTHERS"
        }
        return ""
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
