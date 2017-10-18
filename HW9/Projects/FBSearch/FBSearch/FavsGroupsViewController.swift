//
//  FavsGroupsViewController.swift
//  FBSearch
//
//  Created by Matheos Asfaw on 4/16/17.
//  Copyright © 2017 MADesign. All rights reserved.
//

import UIKit

import Alamofire
import SwiftSpinner
import SwiftyJSON
import AlamofireImage

class FavsGroupsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var resultTableView: UITableView!
    var storedUsers = [[String]]()
    
    
    
    var nextLink = ""
    var prevLink = ""
    
    var favIcons : Array = [UIImage]()
    
    var jsonFromSearch =  JSON("")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favIcons = [UIImage(named:"favs_filled")!, UIImage(named:"favs_empty")!]
        
        
        if revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
            
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        storedUsers = [[String]]()
        
        let allKeys = UserDefaults.standard.dictionaryRepresentation().keys
        
        
        for key in allKeys{
            
            // print (key)
            
            
            if let dat = UserDefaults.standard.value(forKey: key) as? [Data] {
                //print ("found Data Array")
                
                let unPackedId = NSKeyedUnarchiver.unarchiveObject(with: dat[0] as Data) as! String
                let unPackedName = NSKeyedUnarchiver.unarchiveObject(with: dat[1] as Data) as! String
                let unPackedType = NSKeyedUnarchiver.unarchiveObject(with: dat[2] as Data) as! String
                let unPackedPic = NSKeyedUnarchiver.unarchiveObject(with: dat[3] as Data) as! String
                
                
                
                if unPackedType == "group"{
                    let user = [unPackedId,unPackedName,unPackedType,unPackedPic]
                    // print (user)
                    storedUsers.append(user)
                }
            }
            
        }
        
        
        resultTableView.reloadData()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavsCell", for: indexPath) as! ResultsCell
        //print ("getting cell Data ")
        
        if  let imageURLString : String = storedUsers[indexPath.row][3]{
            
            Alamofire.request(imageURLString).responseImage { response in
                
                if let image = response.result.value {
                    //print("image downloaded: \(image)")
                    
                    cell.userProfileIcon.contentMode = .scaleAspectFill
                    cell.userProfileIcon.image = image
                }
            }
        }
        
        //print (imageURLString)
        
        
        
        cell.userNameLbl?.text =  storedUsers[indexPath.row][1]
        cell.userFavsIcon.image = favIcons[0] // 1 means empty
        
        
        
        return cell
    }
    
    /*****************/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storedUsers.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tabBarController?.tabBar.isHidden = true
        
        
        
        idForDetialsSearch = storedUsers[indexPath.row][0]
        
        nameForDetialsSearch = storedUsers[indexPath.row][1]
        typeForDetailsSearch = storedUsers[indexPath.row][2]
        
        profilePicForDetilsSearch = storedUsers[indexPath.row][3]
        performSegue(withIdentifier: "GroupFavsDetail", sender: nil)
        
        
        
    }
    

    



}
