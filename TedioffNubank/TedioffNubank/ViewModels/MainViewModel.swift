  //
//  MainViewModel.swift
//  TedioffMVVM
//
//  Created by Débora Oliveira on 01/09/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import Foundation

// MARK: - MainViewModel

struct MainViewModel {

    // MARK: - Variables
    
    private let apiService: Network
    
    private var cardViewModel: CardViewModel
    
    private var activity: Activity? {
        // FIXME: Rx?
        didSet {
            self.cardViewModel.activity = activity ?? Activity.mocked
        }
    }
    private let buttonEnabled: Bool
    private let buttonText: String = "New activity"
    private var isLoading: Bool
    
    // MARK: - Initializers
    
    init(status: ViewStatus, api: Network = Network.shared) {
        
        switch status {
        case .showing(let newActivity):
            buttonEnabled = true
            isLoading = false
            activity = newActivity
        case .loading:
            buttonEnabled = false
            isLoading = true
            activity = Activity.mocked
        }
        
        apiService = api
        cardViewModel = CardViewModel(activity: activity ?? Activity.mocked)
        
    }
    
    // MARK: - Class methods
    
    func configure(_ view: CardView?) {
        view?.setViewValues(title: cardViewModel.title,
                            type: (cardViewModel.cardRowViewModels[0].image, cardViewModel.cardRowViewModels[0].text),
                            accessibility: (cardViewModel.cardRowViewModels[1].image, cardViewModel.cardRowViewModels[1].text),
                            price: (cardViewModel.cardRowViewModels[2].image, cardViewModel.cardRowViewModels[2].text),
                            participants: (cardViewModel.cardRowViewModels[3].image, cardViewModel.cardRowViewModels[3].text))
    }
}
