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
    
    // MARK: Variables and Properties
    
    var activity: String
    var accessibility: Float
    var type: ActivityType
    var participants: Int
    var price: Float
    var link: String?
    var key: String
    
    var description: String {
        return """
        Name: \(activity)
        Accessibility: \(accessibility)
        Type: \(type)
        Participants: \(participants)
        Price: \(price)
        Key: \(key)
        """
    }
    
    static var mocked = Activity(activity: "", accessibility: 0.0, type: .busywork, participants: 0, price: 0.0, link: nil, key: "")
    
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
