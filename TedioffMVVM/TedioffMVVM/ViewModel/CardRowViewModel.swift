//
//  CardRowViewModel.swift
//  TedioffMVVM
//
//  Created by Débora Oliveira on 01/09/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

public class CardRowViewModel {
    
    private let activityData: (UIImage?,String)
    
    private let isPrice: Bool
    
    init(activity data: (UIImage?,String), isPrice: Bool) {
        self.activityData = data
        self.isPrice = isPrice
    }
    
    public var image: UIImage {
        return activityData.0 ?? UIImage(named: "like")!
    }
    
    public var text: NSMutableAttributedString {
        if isPrice {
            let value = Int(activityData.1) ?? 0
            
            let priceString = NSMutableAttributedString(string: "$$$$$", attributes: [NSAttributedString.Key.font: UIFont.primary!])
            
            priceString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.accent, range: NSRange(location: 0,length: value+1))
            
            return priceString
        } else {
            return NSMutableAttributedString(string: activityData.1)
        }
    }

    func configure(_ view: CardRowView) {
        view.imageView.image = image
        view.label.attributedText = text
    }
}
