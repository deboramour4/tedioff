//
//  MainViewModel.swift
//  TedioffMVVM
//
//  Created by Débora Oliveira on 01/09/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import Foundation

// MARK: - MainViewModel

class MainViewModel {
    
    // MARK: - TypeAlias
    
    typealias NotifyClosure = (()->())
    typealias BooleanClosure = ((Bool)->())
    
    // MARK: - Closures
    
    var updateActivity: NotifyClosure?
    var updateLoadingStatus: BooleanClosure?
    
    // MARK: - Variables
    
    private let apiService: Network
    
    private var cardViewModel: CardViewModel
    
    private var activity = Activity.mocked {
        didSet {
            self.cardViewModel.activity = activity
            self.updateActivity?()
        }
    }
    private var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?(isLoading)
        }
    }
    
    // MARK: - Initializers
    
    init(api: Network) {
        self.apiService = api
        self.isLoading = false
        cardViewModel = CardViewModel(activity: self.activity)
    }
    
    // MARK: - Class methods
    
    func configure(_ view: CardView?) {
        view?.setViewValues(title: cardViewModel.title,
                            type: (cardViewModel.cardRowViewModels[0].image, cardViewModel.cardRowViewModels[0].text),
                            accessibility: (cardViewModel.cardRowViewModels[1].image, cardViewModel.cardRowViewModels[1].text),
                            price: (cardViewModel.cardRowViewModels[2].image, cardViewModel.cardRowViewModels[2].text),
                            participants: (cardViewModel.cardRowViewModels[3].image, cardViewModel.cardRowViewModels[3].text))
    }
    
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
