//
//  FavsUser.swift
//  FBSearch2
//
//  Created by Matheos Asfaw on 4/14/17.
//  Copyright © 2017 MADesign. All rights reserved.
//

import UIKit

class FavsUser: UIViewController, UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        if revealViewController() != nil {
            menuButton.target = self.revealViewController()
            // menuButton.action = "revealToggle:"
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
            
        }
    }


    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = "Cell # \(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print ("row \(indexPath.row) was selected")

        
        performSegue(withIdentifier: "FavsUserToDetails", sender: nil)
        
    }
}
