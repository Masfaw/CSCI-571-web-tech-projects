//
//  entity.swift
//  FBSearch
//
//  Created by Matheos Asfaw on 4/16/17.
//  Copyright © 2017 MADesign. All rights reserved.
//

import Foundation


class entity {

    var id = String()
    var name = String()
    var pic = String()
    var type = String()
    
    
    init(pId : String ,pName : String, pPic: String, pType : String) {
        id = pId
        name = pName
        pic = pPic
        type = pType
        
    }
    
    init(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as! String
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.pic = aDecoder.decodeObject(forKey: "pic") as! String
        self.type = aDecoder.decodeObject(forKey: "type") as! String
        
    }
    
    func initWithCoder (aDecoder : NSCoder) -> entity{
        self.id = aDecoder.decodeObject(forKey: "id") as! String
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.pic = aDecoder.decodeObject(forKey: "pic") as! String
        self.type = aDecoder.decodeObject(forKey: "type") as! String
        
        return self
        
    }
    
    
    func encodeWithCoder(aCoder: NSCoder!){
        aCoder.encodeConditionalObject(name, forKey: "name")
        aCoder.encodeConditionalObject(id , forKey: "id")
        aCoder.encodeConditionalObject(type, forKey: "type")
        aCoder.encodeConditionalObject(pic, forKey: "pic")
        
    }
    

}
