//
//  ResultsEventsViewController.swift
//  FBSearch
//
//  Created by Matheos Asfaw on 4/15/17.
//  Copyright © 2017 MADesign. All rights reserved.
//

import UIKit

import Alamofire
import SwiftSpinner
import SwiftyJSON
import AlamofireImage


class ResultsEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var resultTableView: UITableView!
    
    @IBOutlet weak var previousButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    
    
    var nextLink = ""
    var prevLink = ""
    
    var favIcons : Array = [UIImage]()
    
    var jsonFromSearch =  JSON("")
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        favIcons = [UIImage(named:"favs_filled")!, UIImage(named:"favs_empty")!]
        
        SwiftSpinner.show("Loading")
        
        if keyWordTextFromUser != ""{
            
            getDataFromServer()
            
        }
        
        if revealViewController() != nil {
            menuButton.target = self.revealViewController()
            
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
            
        }
        
        
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        resultTableView.reloadData()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    
    
    
    func getDataFromServer(){
        
        var stringArray = keyWordTextFromUser.components(separatedBy: " ")
        
        var formatedKey = keyWordTextFromUser
        
//        for i in 0..<stringArray.count {
//            formatedKey += stringArray[i]
//            if (i != (stringArray.count - 1) ){
//                formatedKey += "+"
//            }
//            
//        }
        
        Alamofire.request("http://sample-env.3ksm2sdv9u.us-west-2.elasticbeanstalk.com/index.php?key=\(formatedKey)&type=events&det=false&tab=true").responseJSON { response in
            
            let jsonObject = JSON(response.result.value)
           // print (jsonObject)
            
            
            
            self.jsonFromSearch = jsonObject["events"]
            // print(self.jsonFromSearch)
            
            self.nextButton.isHidden = true
            self.previousButton.isHidden = true
            
            if let next = jsonObject["events"]["paging"]["next"].string{
                self.nextButton.isHidden = false
                self.nextLink = next
            }
            if let prev = jsonObject["events"]["paging"]["previous"].string{
                self.previousButton.isHidden = false
                self.prevLink = prev
            }
            
        
            self.resultTableView.reloadData()
            
            SwiftSpinner.hide()
            
        }
        
    }
    
    
    @IBAction func getNextPage(_ sender: UIButton) {
        
        
        
        if nextLink  != ""{
            Alamofire.request(nextLink).responseJSON { response in
                
                self.jsonFromSearch = JSON(response.result.value)
                
                self.nextButton.isHidden = true
                self.previousButton.isHidden = true
                
                
                if let next = self.jsonFromSearch["paging"]["next"].string{
                    self.nextButton.isHidden = false
                    self.nextLink = next
                }
                if let prev = self.jsonFromSearch["paging"]["previous"].string{
                    self.previousButton.isHidden = false
                    self.prevLink = prev
                }
                
                self.resultTableView.reloadData()
            }
        }
        
        
        
        
        
    }
    
    
    
    
    /**
     * This function deals with pagination in getting the next page of data
     */
    
    
    @IBAction func getPrevPage(_ sender: UIButton) {
        
        
        if prevLink  != ""{
            Alamofire.request(prevLink).responseJSON { response in
                
                
                self.jsonFromSearch = JSON(response.result.value)
                
                //print (self.jsonFromSearch)
                
                self.nextButton.isHidden = true
                self.previousButton.isHidden = true
                
                
                if let next = self.jsonFromSearch["paging"]["next"].string{
                    self.nextButton.isHidden = false
                    self.nextLink = next
                }
                if let prev = self.jsonFromSearch["paging"]["previous"].string{
                    self.previousButton.isHidden = false
                    self.prevLink = prev
                }
                
                
                
                
                
                self.resultTableView.reloadData()
                
            }
        }
        
        
        
        
    }

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventsCell", for: indexPath) as! ResultsCell
         //print ("getting cell Data ")
        
        
        
        
        let imageURLString = jsonFromSearch["data"][indexPath.row]["picture"]["data"]["url"].string!
        
        
        //print (imageURLString)
        
        
        Alamofire.request(imageURLString).responseImage { response in
            
            if let image = response.result.value {
                //print("image downloaded: \(image)")
                
                cell.userProfileIcon.contentMode = .scaleAspectFill
                cell.userProfileIcon.image = image
            }
        }
        
        if let name = jsonFromSearch ["data"][indexPath.row]["name"].string{
            cell.userNameLbl?.text = name
            // print (name)
        }
        
        var id = jsonFromSearch ["data"][indexPath.row]["id"].string
        
        id! += "event"

        if let dat = UserDefaults.standard.value(forKey: id!) as? [Data]{ //let object = UserDefaults.standard.object(forKey: id! ) {
            
            
            var unPackedType = NSKeyedUnarchiver.unarchiveObject(with: dat[2] as Data) as! String
            print ("this is a user unpacked is => \(unPackedType)")
            if unPackedType == "event"{
                cell.userFavsIcon.image = favIcons[0]
            }else {
                cell.userFavsIcon.image = favIcons[1] // 1 means empty
            }
            
        }else {
            cell.userFavsIcon.image = favIcons[1] // 1 means empty
        }

        
        
//        if UserDefaults.standard.object(forKey: id! ) != nil{
//            cell.userFavsIcon.image = favIcons[0]
//        }else {
//            cell.userFavsIcon.image = favIcons[1] // 1 means empty
//        }
//        
        return cell
    }
    
    
    
    /*****************/
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonFromSearch["data"].count
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tabBarController?.tabBar.isHidden = true
        
        if let name = jsonFromSearch ["data"][indexPath.row]["name"].string,
            let id = jsonFromSearch ["data"][indexPath.row]["id"].string {
            
            idForDetialsSearch = id 
            nameForDetialsSearch = name
            typeForDetailsSearch = "event"
            
            profilePicForDetilsSearch = jsonFromSearch["data"][indexPath.row]["picture"]["data"]["url"].string!
            
            
            performSegue(withIdentifier: "EventsResultsDetail", sender: nil)
            
            
        }
        
        
        
        
        
        
        
    }
    
    
    
    
}
