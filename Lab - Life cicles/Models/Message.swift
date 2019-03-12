//
//  Message.swift
//  Lab - Life cicles
//
//  Created by Arkadiy Grigoryanc on 12/03/2019.
//  Copyright © 2019 Arkadiy Grigoryanc. All rights reserved.
//

import UIKit

struct Message {
    
    let functionName: String
    let title: String?
    let color: UIColor?
    let date: Date
    
    var dateString: String {
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "HH:mm:ssss"
        
        return formatter.string(from: date)
    }
    
}
