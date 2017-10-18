//
//  DetailsAlbumsTableVC.swift
//  FBSearch
//
//  Created by Matheos Asfaw on 4/14/17.
//  Copyright © 2017 MADesign. All rights reserved.
//

import UIKit

class DetailsAlbumsTableVC: UITableViewCell {
    
    
    var isObserving = false
    
 
    
    @IBOutlet weak var albumTitle: UILabel!

    @IBOutlet weak var firstImage: UIImageView!
    
    @IBOutlet weak var secondImage: UIImageView!
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
     class var twoImageHeight: CGFloat { get { return 500 } }
    
    class var oneImageHeight: CGFloat { get { return 270 } }
    class var defaultHeight: CGFloat  { get { return 45  } }
    
    func checkHeight() {
       
        
        firstImage.isHidden = (frame.size.height < DetailsAlbumsTableVC.oneImageHeight)
        secondImage.isHidden = (frame.size.height < DetailsAlbumsTableVC.twoImageHeight)
    }
    
    func watchFrameChanges() {
        if !isObserving {
            addObserver(self, forKeyPath: "frame", options: [NSKeyValueObservingOptions.new, NSKeyValueObservingOptions.initial], context: nil)
            isObserving = true;
        }
    }
    
    func ignoreFrameChanges() {
        if isObserving {
            removeObserver(self, forKeyPath: "frame")
            isObserving = false;
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "frame" {
            checkHeight()
        }
    }

}
