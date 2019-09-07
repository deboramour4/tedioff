//
//  CardRowViewModel.swift
//  TedioffMVVM
//
//  Created by Débora Oliveira on 01/09/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import Foundation
import UIKit

// MARK: - CardRowViewModel
// FIXME: Isso aqui seria melhor com generics

struct CardRowViewModel {
    
    // MARK: - Variables
    
    private let activityData: (type: String, value: String)
    
    // MARK: - Initializers
    
    init(activity data: (type: String, value: String)) {
        self.activityData = data
    }
    
    // MARK: - Computed properties
    
    public var image: UIImage {
        return UIImage(named: activityData.type) ?? UIImage(named: "like")!
    }
    
    public var text: NSMutableAttributedString {
        if activityData.type == "price" {
            let value = Int(activityData.value) ?? 0
            
            let priceString = NSMutableAttributedString(string: "$$$$$", attributes: [NSAttributedString.Key.font: UIFont.primary ?? UIFont.systemFont(ofSize: 18)])
            
            priceString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.accent, range: NSRange(location: 0,length: value+1))
            
            return priceString
        } else {
            return NSMutableAttributedString(string: activityData.value)
        }
    }
}
