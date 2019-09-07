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
    
    let cardRowViewModels: [CardRowViewModel]?
    let title: String?
    let type: String?
    let accessibility: String?
    let price: String?
    let participants: String?
    let emptyTitleIsHidden: Bool
    let emptyTitle: String = "Nothing to show"
    
    // MARK: - Initializers
    
    init(status: ViewStatus) {
        
        switch status {
        case .showing(let newActivity):
            
            title = newActivity.activity
            type = newActivity.type.rawValue.capitalized
            accessibility = newActivity.accessibility.description
            price = Int(newActivity.price * 4).description
            participants = newActivity.participants == 1 ? newActivity.participants.description + " participant" : newActivity.participants.description + " participants"
            emptyTitleIsHidden = true
            
            cardRowViewModels = [
                CardRowViewModel(activity: ("type", type!)),
                CardRowViewModel(activity: ("accessibility", accessibility!)),
                CardRowViewModel(activity: ("price", price!)),
                CardRowViewModel(activity: ("participants", participants!))
            ]
        case .loading, .empty:
            title = nil
            type = nil
            accessibility = nil
            price = nil
            participants = nil
            emptyTitleIsHidden = false
            cardRowViewModels = nil
        }
    }
}
