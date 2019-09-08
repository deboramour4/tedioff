//
//  CardRowViewModel.swift
//  TedioffMVVM
//
//  Created by Débora Oliveira on 01/09/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// How to fix this?
import UIKit

// MARK: - CardRowViewModel

struct CardRowViewModel {
    
    // Inputs
    public let activityData = PublishSubject<(type: String, value: String)?>()
    
    public let value: String? = nil
    
    // Outputs
    public let imageName: Observable<String?>
    public let text: Observable<NSMutableAttributedString?>
    
    // MARK: - Initializers
    
    init() {
        
        imageName  = activityData
            .map { $0 == nil ? nil : $0?.type }
        
        text = activityData
            .map {
                guard let data = $0 else { return nil }
                
                if data.type == "price" {
                    let value = Int(data.value) ?? 0
        
                    let priceString = NSMutableAttributedString(string: "$$$$$", attributes: [NSAttributedString.Key.font: UIFont.primary ?? UIFont.systemFont(ofSize: 18)])
        
                    priceString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.accent, range: NSRange(location: 0,length: value+1))
        
                    return priceString
                } else {
                    return NSMutableAttributedString(string: data.value)
                }
            }
    }
    
}
