//
//  ViewController.swift
//  FBSearch
//
//  Created by Matheos Asfaw on 4/12/17.
//  Copyright © 2017 MADesign. All rights reserved.
//

import UIKit
import EasyToast
import SwiftSpinner

import MapKit
import CoreLocation

//
//protocol KeyWordSentDelelegate{
//
//    func getKeyWordFromSearchBar(data : String)
//}

var keyWordTextFromUser = ""
var locString = ""

class FBSearchViewController: UIViewController, UITextFieldDelegate,CLLocationManagerDelegate {

    
//    var delegate : KeyWordSentDelelegate? = nil
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
   
    @IBOutlet weak var keyWord: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    
    let manager = CLLocationManager()
    
    
    
    
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        
        keyWord.text = ""
        keyWord.resignFirstResponder()
        
        
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        
        if keyWord.text == ""{
            print("Please enter a keyword")
            self.view.showToast("Enter a valid query!", position: .bottom, popTime: 2, dismissOnTap: false)
        }
        else{
            
            
//            var originalString = "test/test"
//            var escapedString = originalString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
//            print(escapedString!)
            
            
            keyWordTextFromUser = keyWord.text!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
          
//            let revealViewController:SWRevealViewController = self.revealViewController()
//            let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
//            let desController = mainStoryboard.instantiateViewController(withIdentifier: "ResultsTabBarController") as! ResultsTabBarController
//            let newFrontViewController = UINavigationController.init(rootViewController:desController)
//            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
         
            performSegue(withIdentifier: "searchResults", sender: nil)
            
            
        }
        
        
         keyWord.resignFirstResponder()
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        keyWord.resignFirstResponder()
        searchButtonPressed(searchButton)
        return false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        keyWord.text = ""
        keyWord.delegate = self
        
        
//        menuButton.target = revealViewController()
//        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        
        if revealViewController() != nil {
            menuButton.target = self.revealViewController()
            // menuButton.action = "revealToggle:"
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
            
        }
        
        print ("The location string in view did load of FBSearch \(locString)" )
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        locString = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
        //print ("lat = \(location.coordinate.latitude)  long \(location.coordinate.longitude)")
        
        //print (locString)
        
    }


}

