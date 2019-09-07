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
    
    var cardRowViewModels: [CardRowViewModel] = [CardRowViewModel]()
    
    var activity: Activity {
        didSet {
            createRowViewModels()
        }
    }
    var title: String {
        return activity.activity
    }
    var type: String {
        return activity.type.rawValue.capitalized
    }
    var accessibility: String {
        return activity.accessibility.description
    }
    var price: String {
        let priceValue = Int(activity.price * 4)
        return priceValue.description
    }
    var participants: String {
        if activity.participants == 1 {
            return activity.participants.description + " participant"
        } else {
            return activity.participants.description + " participants"
        }
    }
    
    // MARK: - Initializers
    
    init(activity: Activity) {
        self.activity = activity
        self.createRowViewModels()
    }
    
    mutating func createRowViewModels() {
        cardRowViewModels = [
            CardRowViewModel(activity: ("type", type)),
            CardRowViewModel(activity: ("accessibility", accessibility)),
            CardRowViewModel(activity: ("price", price)),
            CardRowViewModel(activity: ("participants", participants))
        ]
    }
    
    // MARK: Class Methods
    
    func getViewModel(for type: String) -> CardRowViewModel? {
        let cardRowViewModel = cardRowViewModels.filter { (viewModel) -> Bool in
            if viewModel.type == type {
                return true
            }
            return false
        }
        
        return cardRowViewModel.first
    }
    
}
