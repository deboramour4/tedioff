//
//  ActivityManager.swift
//  TedioffMVVM
//
//  Created by Débora Oliveira on 07/09/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import Foundation

// MARK: - ActivityManager

class ActivityManager {
    
    // MARK: - Typealias
    
    typealias GetActivity = ((Activity?) -> Void)
    
    // MARK: - Properties
    
    private let service: Network
    
    // MARK: - Initialization
    
    init(service: Network = Network(api: URL(string: "https://www.boredapi.com/api/activity/"))) {
        self.service = service
    }
    
    // MARK: - ClassMethods
    
    func getActivity(_ completion: @escaping GetActivity) {
        service.requestJSON(type: Activity.self, completion: { (error, activity) in
            DispatchQueue.main.async {
                completion(activity)
            }
        })
    }
}

