//
//  BaseModel.swift
//  FourDayStudy
//
//  Created by le tong on 2019/9/29.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

class BaseModel: NSObject {
     let name: String
     let content: String
    let category: String
    
    
    init(name: String, content: String, category: String) {
        self.name = name
        self.content = content
        self.category = category
    }
}
