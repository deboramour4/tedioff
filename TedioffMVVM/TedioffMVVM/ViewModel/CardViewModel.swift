//
//  CardViewModel.swift
//  TedioffMVVM
//
//  Created by Débora Oliveira on 01/09/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit
//
// MARK: - CardViewModel
//
public class CardViewModel {
    //
    // MARK: - Variables
    //
    private let apiService: Network
    
    var cardRowViewModels: [CardRowViewModel] = [CardRowViewModel]()
    
    private var activity: Activity = Activity() {
        didSet {
            createRowViewModels()
            self.updateActivity?()
        }
    }
    
    //
    // MARK: - Closures
    //
    var updateActivity: (()->())?
    var updateLoadingStatus: (()->())?
    
    //
    // MARK: - Initializers
    //
    init(api: Network) {
        self.apiService = api
        self.isLoading = false
        self.createRowViewModels()
    }
    
    func createRowViewModels() {
        self.cardRowViewModels = [
            CardRowViewModel(activity: (UIImage(named: "tag"), type), isPrice: false),
            CardRowViewModel(activity: (UIImage(named: "like"), accessibility), isPrice: false),
            CardRowViewModel(activity: (UIImage(named: "money"), price), isPrice: true),
            CardRowViewModel(activity: (UIImage(named: "people"), participants), isPrice: false)
        ]
    }
    
    //
    // MARK: - Computed properties
    //
    // FIXME: isso é publico msm?
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
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    //
    // MARK: - Class methods
    //
    func fetchNewActivity() {
        self.isLoading = true
        apiService.requestJSON { [weak self] (error, activity) in
            if let unwrapedActivity = activity {
                self?.activity = unwrapedActivity
            }
            self?.isLoading = false
        }
    }
}
