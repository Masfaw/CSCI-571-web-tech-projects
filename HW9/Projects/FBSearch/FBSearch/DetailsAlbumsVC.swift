//
//  DetailsAlbumsVC.swift
//  FBSearch
//
//  Created by Matheos Asfaw on 4/14/17.
//  Copyright © 2017 MADesign. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftSpinner
import SwiftyJSON
import EasyToast
import FacebookShare
import FBSDKShareKit
import FBSDKLoginKit



class DetailsAlbumsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, FBSDKSharingDelegate  {
    
    
    
    var jsonFromSearch = JSON("")
   var selectedIndexPath : IndexPath?
    
    @IBOutlet weak var albumsTable: UITableView!
    @IBOutlet weak var noDataLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        SwiftSpinner.show("Loading")
        
        //print("loading")
        if idForDetialsSearch != ""{
            getDetailsAlbums()
        }
    }
    
    

    
    
  func  getDetailsAlbums(){
    
    
    let url = "http://sample-env.3ksm2sdv9u.us-west-2.elasticbeanstalk.com/index.php?&type=users&det=true&tab=false&id=\(idForDetialsSearch)"
    //print (url)
    
    Alamofire.request(url).responseJSON { response in
        
        if let jsonFile = response.result.value {
            
            self.jsonFromSearch = JSON(response.result.value!)
            
            // print (self.jsonFromSearch)
            // print (self.jsonFromSearch["albums"]["data"].count)
            //print (self.jsonFromSearch["albums"].count)
            
            
            
            //self.jsonFromSearch = jsonObject["users"]
            
            //        if let json = response.result.value {
            //            //print("JSON: \(JSON)")
            //        }
            
            if self.jsonFromSearch["albums"]  != JSON.null {
               // print (self.jsonFromSearch["albums"])
                // print ("has an album")
                
                if(self.jsonFromSearch["albums"]["data"].count  == 0 ){
                    SwiftSpinner.hide()
                    self.noDataLbl.isHidden = false
                    self.albumsTable.isHidden = true
                }
                
            }
            else{
                self.noDataLbl.isHidden = false
                self.albumsTable.isHidden = true
                //  print("doesnt have albums")
            }
            
            self.albumsTable.reloadData()
            SwiftSpinner.hide()
            
            
        }
        else {
            SwiftSpinner.hide()
            self.noDataLbl.isHidden = false
            self.albumsTable.isHidden = true
        }
        

        
        }
    
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print ("has \(jsonFromSearch["albums"]["data"].count)  rows")
        return self.jsonFromSearch["albums"]["data"].count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "albumsCell", for: indexPath) as! DetailsAlbumsTableVC
    
        //let cell = UITableViewCell()
        let title: String? = jsonFromSearch["albums"]["data"][indexPath.row]["name"].string

        cell.albumTitle?.text = title
        
       // print (jsonFromSearch["albums"]["data"][indexPath.row]["name"].string!)
        if let image1 = jsonFromSearch["albums"] ["data"] [indexPath.row]["photos"]["data"][0]["picture"].string{
            
            Alamofire.request(image1).responseImage { response in
            
                if let image = response.result.value {
                    
                    cell.firstImage.contentMode = .scaleAspectFit
                    cell.firstImage.image = image
                    
                }
            
            }
            
            if let image2 = jsonFromSearch["albums"] ["data"] [indexPath.row]["photos"]["data"][1]["picture"].string{
            

                Alamofire.request(image2).responseImage { response in
                    
                    if let image = response.result.value {
                        
                        cell.secondImage.contentMode = .scaleAspectFit
                        cell.secondImage.image = image
                        
                    }
                    
                }

            
            }
            else {
                print ("No Second image *****************************************")
            }
        }
        else {
            print ("Has NO IMAGES *********************")
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print ("Selected row \(indexPath.row)")
        let previousIndexPath = selectedIndexPath
        if indexPath == selectedIndexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        
        var indexPaths : Array<IndexPath> = []
        if let previous = previousIndexPath {
            indexPaths += [previous]
        }
        if let current = selectedIndexPath {
            indexPaths += [current]
        }
        if indexPaths.count > 0 {
            tableView.reloadRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
        }

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! DetailsAlbumsTableVC).watchFrameChanges()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! DetailsAlbumsTableVC).ignoreFrameChanges()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        for cell in albumsTable.visibleCells as! [DetailsAlbumsTableVC] {
            cell.ignoreFrameChanges()
        }
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == selectedIndexPath {
            
            
            if jsonFromSearch["albums"]["data"][indexPath.row]["photos"]["data"].count == 2 {
                return DetailsAlbumsTableVC.twoImageHeight
            
            }
            else if jsonFromSearch["albums"]["data"][indexPath.row]["photos"]["data"].count == 1 {
                return DetailsAlbumsTableVC.oneImageHeight
            }
            else {
                return DetailsAlbumsTableVC.defaultHeight
            }
            
        }
        else {
            return DetailsAlbumsTableVC.defaultHeight
        }
        
        //return DetailsAlbumsTableVC.defaultHeight
    }
    
    
    
    
    @IBAction func RetrunButtonTapped(_ sender: Any) {
        
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
            print ("added to favs ")
        
        }
        
        
        let removeFromFavsButoom = UIAlertAction(title: "Remove from Favorites", style: UIAlertActionStyle.default){ (ACTION) in
            
            UserDefaults.standard.removeObject(forKey: idForDetialsSearch)
            
            self.view.showToast("Removed from favorites!", position: .bottom, popTime: 2, dismissOnTap: false)
           // print ("removed from favs")
        }
        
        
        
        let shareOnFBButton = UIAlertAction(title: "Share", style: UIAlertActionStyle.default){  (ACTION) in
            
            
            
            let myContent = FBSDKShareLinkContent()
            myContent.contentURL = URL(string: profilePicForDetilsSearch)
            //myContent.contentURL = URL(string: "http://www.matheosasfaw.com/")
            
            myContent.contentTitle = nameForDetialsSearch
            myContent.imageURL =  URL(string: profilePicForDetilsSearch)
            myContent.contentDescription = "FB Share for CSCI 571"
            
            
            //FBSDKShareDialog.show(from: self, with: myContent, delegate: self)
            
            
//            
//           // let myContent = LinkShareContent(url: URL(string: "http://www.matheosasfaw.com/")!)
//            
//            let myContent = LinkShareContent(url: URL(string: profilePicForDetilsSearch)!, title: nameForDetialsSearch, description: "FB Share for CSCI 571", quote: "", imageURL: URL(string: profilePicForDetilsSearch))
//            
//           // myContent.contentURL = URL(string: profilePicForDetilsSearch)
////            myContent.contentURL = URL(string: "http://www.matheosasfaw.com/")
////            
////            myContent.contentTitle = nameForDetialsSearch
////            myContent.imageURL =  URL(string: profilePicForDetilsSearch)
////            myContent.contentDescription = "FB Share for CSCI 571"
////            
////        
            
//            
            let  dialog = FBSDKShareDialog()
            dialog.fromViewController = self
            dialog.delegate = self
            dialog.shareContent = myContent
            dialog.mode = FBSDKShareDialogMode.feedWeb
            dialog.show()
            
            
            //FBSDKShareDialog.show(from: self, with: myContent, delegate: nil)
           
            
            
//            FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
//            content.contentURL = [NSURL URLWithString:@"https://developers.facebook.com"];
//            
//            FBSDKShareDialog *dialog = [[FBSDKShareDialog alloc] init];
//            dialog.fromViewController = self;
//            dialog.content = content;
//            dialog.mode = FBSDKShareDialogModeShareSheet;
//            [dialog show];
            
  
            
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
                print ("the Id for the object is \(unPackedId)")
                
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
