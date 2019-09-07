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
    
    var cardViewModel: CardViewModel
    let newActivityButtonEnabled: Bool
    let newActivityButtonTitle: String = "New activity"
    let clearButtonEnabled: Bool
    let clearButtonTitle: String = "Clear"
    var isLoading: Bool
    
    // MARK: - Initializers
    
    init(status: ViewStatus) {
        
        switch status {
        case .showing(let newActivity):
            newActivityButtonEnabled = true
            clearButtonEnabled = true
            isLoading = false
            cardViewModel = CardViewModel(status: .showing(newActivity))
        case .loading:
            newActivityButtonEnabled = false
            clearButtonEnabled = false
            isLoading = true
            cardViewModel = CardViewModel(status: .loading)
        case .empty:
            newActivityButtonEnabled = true
            clearButtonEnabled = false
            isLoading = false
            cardViewModel = CardViewModel(status: .empty)
        }
    }
    
    // MARK: - Class methods
    
    func configure(_ view: GetActivityView?) {
        view?.setViewValues(newActivityButtonIsEnabled: newActivityButtonEnabled,
                            newActivityButtonTitle: newActivityButtonTitle,
                            clearButtonIsEnabled: clearButtonEnabled,
                            clearButtonTitle: clearButtonTitle,
                            emptyTitleIsHidden: cardViewModel.emptyTitleIsHidden,
                            emptyTitle: cardViewModel.emptyTitle,
                            isLoading: isLoading,
                            title: cardViewModel.title,
                            type: (cardViewModel.cardRowViewModels?[0].image, cardViewModel.cardRowViewModels?[0].text),
                            accessibility: (cardViewModel.cardRowViewModels?[1].image, cardViewModel.cardRowViewModels?[1].text),
                            price: (cardViewModel.cardRowViewModels?[2].image, cardViewModel.cardRowViewModels?[2].text),
                            participants: (cardViewModel.cardRowViewModels?[3].image, cardViewModel.cardRowViewModels?[3].text))
    }
}
