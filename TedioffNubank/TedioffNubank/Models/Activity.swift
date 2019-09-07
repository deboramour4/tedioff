//
//  Activity.swift
//  TedioffMVC
//
//  Created by Débora Oliveira on 30/08/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import Foundation

// MARK: - Activity

class Activity: Decodable {
    
    // MARK: - ActivityType
    
    enum ActivityType: String, Decodable {
        
        // MARK: - Cases
        
        case education
        case recreational
        case social
        case diy
        case charity
        case cooking
        case relaxation
        case music
        case busywork
    }
    
    // MARK - Properties
    
    var activity: String
    var accessibility: Float
    var type: ActivityType
    var participants: Int
    var price: Float
    var link: String?
    var key: String
    
    // MARK: - Initialization
    
    init(activity: String, accessibility: Float, type: ActivityType, participants: Int, price: Float, link: String?, key: String) {
        self.activity = activity
        self.accessibility = accessibility
        self.type = type
        self.participants = participants
        self.price = price
        self.link = link
        self.key = key
    }
}
