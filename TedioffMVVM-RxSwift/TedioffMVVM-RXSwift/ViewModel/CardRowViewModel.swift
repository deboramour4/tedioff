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

// MARK: - CardRowViewModel

struct CardRowViewModel {
        
    // Outputs
    public let type: Observable<ActivityAttributes>
    public let text: Observable<NSMutableAttributedString?>
    
    // MARK: - Initializers
    
    init(type: ActivityAttributes = .type, value: Observable<String?> = .just(nil)) {
        
        self.type = .just(type)
        
        text = value
            .map {
                guard let value = $0 else { return nil }
                
                if type == .price {
                    let value = Int(value) ?? 0
        
                    let priceString = NSMutableAttributedString(string: "$$$$$", attributes: [NSAttributedString.Key.font: UIFont.primary ?? UIFont.systemFont(ofSize: 18)])
        
                    priceString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.accent, range: NSRange(location: 0,length: value+1))
        
                    return priceString
                } else {
                    return NSMutableAttributedString(string: value)
                }
            }
    }
    
}
