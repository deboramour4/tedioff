//
//  CardViewModel.swift
//  TedioffMVVM
//
//  Created by Débora Oliveira on 01/09/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

public class CardViewModel {
    
    private let activity: Activity
    
    private var cardRowViewModels: [CardRowViewModel] = []
    
    init(activity: Activity) {
        self.activity = activity
        
        self.cardRowViewModels = [
            CardRowViewModel(activity: (UIImage(named: "tag"), type), isPrice: false),
            CardRowViewModel(activity: (UIImage(named: "like"), accessibility), isPrice: false),
            CardRowViewModel(activity: (UIImage(named: "money"), price), isPrice: true),
            CardRowViewModel(activity: (UIImage(named: "people"), participants), isPrice: false)
        ]
    }
    
    private var title: String {
        return activity.activity
    }
    private var type: String {
        return activity.type.rawValue.capitalized
    }
    private var accessibility: String {
        return activity.accessibility.description
    }
    private var price: String {
        let priceValue = Int(activity.price * 4)
        return priceValue.description
    }
    private var participants: String {
        if activity.participants == 1 {
            return activity.participants.description+" participant"
        } else {
            return activity.participants.description+" participants"
        }
    }
    
    func configure(_ view: CardView) {
        view.titleLabel.text = activity.activity
        
        view.typeRowView.viewModel = cardRowViewModels[0]
        view.accessibilityRowView.viewModel = cardRowViewModels[1]
        view.priceRowView.viewModel = cardRowViewModels[2]
        view.participantsRowView.viewModel = cardRowViewModels[3]
    }
}
