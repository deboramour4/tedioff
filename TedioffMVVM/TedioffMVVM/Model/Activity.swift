//
//  Activity.swift
//  TedioffMVC
//
//  Created by Débora Oliveira on 30/08/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import Foundation

//
// MARK: - Activity
//
class Activity: Decodable {
    //
    // MARK: Variables and Properties
    //
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

    //
    // MARK: - Initialization
    //
    // FIXME: de boas mockar assim?
    init(activity: String = "", accessibility: Float = 0.0, type: ActivityType = ActivityType.busywork, participants: Int = 0, price: Float = 0.0, link: String? = "", key: String = "") {
        self.activity = activity
        self.accessibility = accessibility
        self.type = type
        self.participants = participants
        self.price = price
        self.link = link
        self.key = key
    }
    
}
