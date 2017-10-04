//
//  Posts.swift
//  PracticaBoot
//
//  Created by Juan Martin Noguera on 04/10/2017.
//  Copyright © 2017 COM. All rights reserved.
//

import Foundation
import Firebase

struct Posts {
    
    let title : String
    let description : String
    let isVisible: Bool
    let photo: String
    var postRef : DatabaseReference?
    
    init(title: String, description: String, isVisible: Bool = false, photo: String) {
        self.title = title
        self.description = description
        self.isVisible = isVisible
        self.photo = photo
        self.postRef = nil
    }
    
    init?(snapShot: DataSnapshot) {
        guard let item = snapShot.value as? [String:Any] else { return nil }
        self.title = item["title"] as! String
        self.description = item["description"] as! String
        self.isVisible = item["isvisible"] as! Bool
        self.photo = item["photo"] as! String
        self.postRef = snapShot.ref
    }
}
