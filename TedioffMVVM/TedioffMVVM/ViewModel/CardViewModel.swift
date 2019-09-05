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
    // MARK: - TypeAlias
    //
    typealias NotifyClosure = (()->())
    
    //
    // MARK: - Closures
    //
    var updateActivity: NotifyClosure?
    var updateLoadingStatus: NotifyClosure?
    
    //
    // MARK: - Variables
    //
    private let apiService: Network
    
    var cardRowViewModels: [CardRowViewModel] = [CardRowViewModel]()
    
    private var activity = Activity.mocked {
        didSet {
            createRowViewModels()
            self.updateActivity?()
        }
    }
    
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
            CardRowViewModel(activity: ("type", type)),
            CardRowViewModel(activity: ("accessibility", accessibility)),
            CardRowViewModel(activity: ("price", price)),
            CardRowViewModel(activity: ("participants", participants))
        ]
    }
    
    //
    // MARK: - Computed properties
    //
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
            return activity.participants.description + " participant"
        } else {
            return activity.participants.description + " participants"
        }
    }
    // FIXME: Esse pode ser público?
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    func getViewModel(for type: String) -> CardRowViewModel? {
        let cardRowViewModel = cardRowViewModels.filter { (viewModel) -> Bool in
            if viewModel.type == type {
                return true
            }
            return false
        }
        
        return cardRowViewModel.first
    }
    
    func configure(_ view: CardView?) {
        view?.setViewValues(title: title,
                           type: (cardRowViewModels[0].image, cardRowViewModels[0].text),
                           accessibility: (cardRowViewModels[1].image, cardRowViewModels[1].text),
                           price: (cardRowViewModels[2].image, cardRowViewModels[2].text),
                           participants: (cardRowViewModels[3].image, cardRowViewModels[3].text))
    }
    
    //
    // MARK: - Class methods
    //
    func fetchNewActivity() {
        self.isLoading = true
        apiService.requestJSON(type: Activity.self, completion: {[weak self] (error, activity) in
            if let unwrapedActivity = activity {
                self?.activity = unwrapedActivity
            }
            self?.isLoading = false
        })
    }
}
