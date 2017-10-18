//
//  DetailsPostsVC.swift
//  FBSearch
//
//  Created by Matheos Asfaw on 4/15/17.
//  Copyright © 2017 MADesign. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftSpinner
import SwiftyJSON
import AFDateHelper

import FacebookShare
import FBSDKShareKit
import FBSDKLoginKit





class DetailsPostsVC: UIViewController,UITableViewDelegate, UITableViewDataSource, FBSDKSharingDelegate {

    var jsonFromSearch = JSON("")
    var postProfilePic : UIImage?
    
    @IBOutlet weak var noDataLbl: UILabel!
    
    @IBOutlet weak var postsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SwiftSpinner.show("Loading")


        if idForDetialsSearch != ""{
            getDetailsPosts()
        }
        
        postsTableView.rowHeight = UITableViewAutomaticDimension
        postsTableView.estimatedRowHeight   = 72

    }
    
    
    func  getDetailsPosts(){
        
        
        let url = "http://sample-env.3ksm2sdv9u.us-west-2.elasticbeanstalk.com/index.php?&type=users&det=true&tab=false&id=\(idForDetialsSearch)"
        print (url)
        
        Alamofire.request(url).responseJSON { response in
            
            
            if let jsonFile = response.result.value {
            
                self.jsonFromSearch = JSON(response.result.value!)
                //print (self.jsonFromSearch)
                
                if self.jsonFromSearch["posts"]  != JSON.null {
                    //print ("has posts")
                }
                else{
                   // print("doesnt have posts")
                    self.noDataLbl.isHidden = false
                    self.postsTableView.isHidden = true
                }
                
                
                
                
                self.postsTableView.reloadData()
                SwiftSpinner.hide()
            
            
            }
            else {
            
                self.noDataLbl.isHidden = false
                self.postsTableView.isHidden = true
                SwiftSpinner.hide()

            }
            
            
            
         
            
            
        }
        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print ("has \(jsonFromSearch["albums"]["data"].count)  rows")
        return self.jsonFromSearch["posts"]["data"].count
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsCell", for: indexPath) as! DetailsPostsCell
        
        
        
        var image1 = self.jsonFromSearch["picture"]["data"]["url"].string
        //print (image1!)
        
        Alamofire.request(image1!).responseImage { response in
            
            if let image = response.result.value {
                cell.profilePic.contentMode = .scaleAspectFit
                cell.profilePic.image = image
            }
            
        }
                
        

        
        
        if (jsonFromSearch["posts"]["data"] [indexPath.row]["message"].string) != nil{
        
            var mess = jsonFromSearch["posts"]["data"] [indexPath.row]["message"].string!
        
            print ("has Message")
            let dateFormater = DateFormatter()
            
            dateFormater.dateFormat = "dd-MMM-yyyy 'T'HH:mm:ss.SSS'Z'"
            let createdTime = jsonFromSearch["posts"]["data"] [indexPath.row]["created_time"].string!
            
            
            let date =  Date(fromString: createdTime, format: .isoDateTimeSec)
            
           // print (jsonFromSearch["posts"]["data"] [indexPath.row]["created_time"].string!)
            
            let rssDateString = date?.toString(format: .custom("dd MMM yyyy HH:mm:ss"))
            //print (rssDateString!)
            
            mess += "\n\n "
            mess += rssDateString!
            
            cell.messageBox?.text = mess
        }
        else if  jsonFromSearch["posts"]["data"] [indexPath.row]["story"].string != nil {
            
             var mess = jsonFromSearch["posts"]["data"] [indexPath.row]["story"].string!
            
            let dateFormater = DateFormatter()
            
            dateFormater.dateFormat = "dd-MMM-yyyy 'T'HH:mm:ss.SSS'Z'"
            let createdTime = jsonFromSearch["posts"]["data"] [indexPath.row]["created_time"].string!
            
            
            let date =  Date(fromString: createdTime, format: .isoDateTimeSec)
            
            // print (jsonFromSearch["posts"]["data"] [indexPath.row]["created_time"].string!)
            
            let rssDateString = date?.toString(format: .custom("dd MMM yyyy HH:mm:ss"))
            //print (rssDateString!)
            
            mess += "\n\n "
            mess += rssDateString!
            
            cell.messageBox?.text = mess
        }
        
        
       
        
        

        
        
        

        
        return cell
    }
    
    
    
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        
////        
////        let fixedWidth = textView.frame.size.width
////        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
////        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
////        var newFrame = textView.frame
////        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
////        textView.frame = newFrame;
////        
//        
//       // var currentCell =  tableView.cellForRow(at: indexPath) as! DetailsPostsCell
//        
////        
////        let fixedWidth = currentCell.messegeBox.frame.size.width
////        currentCell.messegeBox.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
////        let newSize = currentCell.messegeBox.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
////        
////        var newFrame = currentCell.messegeBox.frame
////        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
////        currentCell.messegeBox.frame = newFrame;
////        
////        
////        return newSize.height + 5
//
//        
//        
//        return 72
//    }
    
    
    @IBAction func reultsButtonHasBeenTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func showMenuOptionsButtonTapped(_ sender: Any) {
        var myActionSheet = UIAlertController(title: "Menu", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        
        let addToFavsButton = UIAlertAction(title: "Add to favorites", style: UIAlertActionStyle.default) { (ACTION) in
            
            
            var toBeSaved = entity(pId: idForDetialsSearch, pName: nameForDetialsSearch, pPic: profilePicForDetilsSearch, pType: typeForDetailsSearch)
            //let toBeSaved = ["id ": idForDetialsSearch, "name": nameForDetialsSearch, "pci": profilePicForDetilsSearch, "type": typeForDetailsSearch]
            
            
            let encodedName = NSKeyedArchiver.archivedData(withRootObject: toBeSaved.name)
            let encodedID = NSKeyedArchiver.archivedData(withRootObject: toBeSaved.id)
            let encodedPIC = NSKeyedArchiver.archivedData(withRootObject: toBeSaved.pic)
            let encodedTYPE = NSKeyedArchiver.archivedData(withRootObject: toBeSaved.type)
            
            let encodedArray : [Data] = [encodedID,encodedName,encodedTYPE,encodedPIC]
            
            
            UserDefaults.standard.set(encodedArray, forKey: idForDetialsSearch + typeForDetailsSearch)
            UserDefaults.standard.synchronize()
            
            //           print (toBeSaved)
            
            
            // UserDefaults.standard.set(toBeSaved, forKey: idForDetialsSearch)
            //
            //
            
            
            
            self.view.showToast("Added to favorites!", position: .bottom, popTime: 2, dismissOnTap: false)
            //print ("added to favs ")
            
        }
        
        
        let removeFromFavsButoom = UIAlertAction(title: "Remove from Favorites", style: UIAlertActionStyle.default){ (ACTION) in
            
            UserDefaults.standard.removeObject(forKey: idForDetialsSearch)
            
            self.view.showToast("Removed from favorites!", position: .bottom, popTime: 2, dismissOnTap: false)
            // print ("removed from favs")
        }
        
        
        
        let shareOnFBButton = UIAlertAction(title: "Share", style: UIAlertActionStyle.default){  (ACTION) in
            
            
            
            
            
            let myContent = FBSDKShareLinkContent()
            myContent.contentURL = URL(string: profilePicForDetilsSearch)
 

            myContent.contentTitle = nameForDetialsSearch
            myContent.imageURL =  URL(string: profilePicForDetilsSearch)
            myContent.contentDescription = "FB Share for CSCI 571"
            
            
            
            let  dialog = FBSDKShareDialog()
            dialog.fromViewController = self
            dialog.delegate = self
            dialog.shareContent = myContent
            dialog.mode = FBSDKShareDialogMode.feedWeb
            dialog.show()
            
           // FBSDKShareDialog.show(from: self, with: myContent, delegate: self)
            //self.view.showToast("Shared!", position: .bottom, popTime: 2, dismissOnTap: false)
           
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive){ (ACTION) in
            
            print ("Cancel has been hit")
            
            
            
            
            
        }
        
        var actionSheetHasRemove = false
        
        
        let allKeys = UserDefaults.standard.dictionaryRepresentation().keys
        
        
        for key in allKeys{
            
            // print (key)
            
            
            if let dat = UserDefaults.standard.value(forKey: key) as? [Data] {
                print ("found Data Array")
                
                var unPackedId = NSKeyedUnarchiver.unarchiveObject(with: dat[0] as Data) as! String
                var unPackedName = NSKeyedUnarchiver.unarchiveObject(with: dat[1] as Data) as! String
                var unPackedType = NSKeyedUnarchiver.unarchiveObject(with: dat[2] as Data) as! String
                var unPackedPic = NSKeyedUnarchiver.unarchiveObject(with: dat[3] as Data) as! String
                
                //                if unPackedType == "user" {
                //                    print ("\(unPackedName) This is a user ^")
                //                }
                //                else if unPackedType == "page" {
                //                    print ("\(unPackedName) this is a pagee ^")
                //                }
                
                
                print ("The key for this object is \(idForDetialsSearch + typeForDetailsSearch)")
                if unPackedId == idForDetialsSearch && unPackedType == typeForDetailsSearch{
                    actionSheetHasRemove = true
                    
                }
                
            }
            
        }
        
        
        if actionSheetHasRemove{
            myActionSheet.addAction(removeFromFavsButoom)
        }
        else {
            myActionSheet.addAction(addToFavsButton)
        }
        
        
        myActionSheet.addAction(shareOnFBButton)
        myActionSheet.addAction(cancelButton)
        
        self.present(myActionSheet, animated: true, completion: nil)
        
    }
    
    func sharerDidCancel(_ sharer: FBSDKSharing!) {
        print("SHare canceled")
        self.view.showToast("Not Shared!", position: .bottom, popTime: 2, dismissOnTap: false)
    }
    
    func sharer(_ sharer: FBSDKSharing!, didFailWithError error: Error!) {
        print("share failed")
        self.view.showToast("Not Shared!", position: .bottom, popTime: 2, dismissOnTap: false)
    }
    
    func sharer(_ sharer: FBSDKSharing!, didCompleteWithResults results: [AnyHashable : Any]!) {
        print(" share completed" )
        self.view.showToast("Shared!", position: .bottom, popTime: 2, dismissOnTap: false)
    }
    


}
