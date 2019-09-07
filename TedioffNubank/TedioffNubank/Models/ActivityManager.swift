//
//  ActivityManager.swift
//  TedioffNubank
//
//  Created by Débora Oliveira on 06/09/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import Foundation

class ActivityManager {
    
    typealias GetActivity = ((Activity?) -> Void)
    
    private let service: Network
    
    init(service: Network = Network.shared) {
        self.service = service
    }
    
    func getActivity(_ completion: @escaping GetActivity) {
        service.requestJSON(type: Activity.self, completion: { [weak self] (error, activity) in
            DispatchQueue.main.async {
                completion(activity)
            }
        })
    }
}

