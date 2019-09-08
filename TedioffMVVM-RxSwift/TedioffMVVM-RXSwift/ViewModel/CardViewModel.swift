//
//  CardViewModel.swift
//  TedioffMVVM
//
//  Created by Débora Oliveira on 01/09/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import Foundation

// MARK: - CardViewModel

struct CardViewModel {
    
    // MARK: - Variables
    
    var cardRowViewModels: [CardRowViewModel]?
    var emptyTitleIsHidden: Bool
    let emptyTitle: String = "Nothing to show"
    
    var activity: Activity? {
        didSet {
            if let _ = activity {
                emptyTitleIsHidden = true
                createRowViewModels()
            } else {
                emptyTitleIsHidden = false
                cardRowViewModels = nil
            }
        }
    }
    var title: String? {
        return activity?.activity
    }
    var type: String? {
        return activity?.type.rawValue.capitalized
    }
    var accessibility: String? {
        return activity?.accessibility.description
    }
    var price: String? {
        if let activity = activity {
            let priceValue = Int(activity.price * 4)
            return priceValue.description
        } else {
            return nil
        }
    }
    var participants: String? {
        if let activity = activity {
            let participantsText = activity.participants == 1 ?
                activity.participants.description + " participant" :
                activity.participants.description + " participants"
            return participantsText
        } else {
            return nil
        }
    }
    
    // MARK: - Initializers
    
    init(activity: Activity?) {
        self.activity = activity
        
        if let _ = activity {
            emptyTitleIsHidden = true
            createRowViewModels()
        } else {
            emptyTitleIsHidden = false
            cardRowViewModels = nil
        }
    }
    
    mutating func createRowViewModels() {
        if activity != nil {
            cardRowViewModels = [
                CardRowViewModel(activity: ("type", type!)),
                CardRowViewModel(activity: ("accessibility", accessibility!)),
                CardRowViewModel(activity: ("price", price!)),
                CardRowViewModel(activity: ("participants", participants!))
            ]
        }
    }
    
}
