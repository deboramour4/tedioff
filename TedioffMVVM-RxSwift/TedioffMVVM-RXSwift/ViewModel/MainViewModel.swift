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
    
    var updateLoadingStatus: BooleanClosure?
    var updateEmptyStatus: NotifyClosure?
    
    // MARK: - Variables
    
    private let service: ActivityManager
    private var cardViewModel: CardViewModel
    private var newActivityButtonEnabled: Bool
    private var clearButtonEnabled: Bool
    private var newActivityButtonTitle: String = "New Activity"
    private var clearButtonTitle: String = "Clear"
    
    private var activity: Activity? {
        didSet {
            cardViewModel.activity = activity
        }
    }
    private var isLoading: Bool {
        didSet {
            updateLoadingStatus?(isLoading)
        }
    }
    private var isEmpty: Bool {
        didSet {
            if isEmpty {
                activity = nil
                clearButtonEnabled = false
            } else {
                clearButtonEnabled = true
            }
            updateEmptyStatus?()
        }
    }
    
    // MARK: - Initializers
    
    init(service: ActivityManager = ActivityManager()) {
        self.service = service
        
        cardViewModel = CardViewModel(activity: self.activity)
        
        isLoading = false
        isEmpty = true
        newActivityButtonEnabled = true
        clearButtonEnabled = false
    }
    
    // MARK: - Class methods
    
    func configure(_ view: GetActivityView?) {
        view?.setViewValues(newActivityButtonIsEnabled: newActivityButtonEnabled,
                            newActivityButtonTitle: newActivityButtonTitle,
                            clearButtonIsEnabled: clearButtonEnabled,
                            clearButtonTitle: clearButtonTitle,
                            emptyTitleIsHidden: cardViewModel.emptyTitleIsHidden,
                            emptyTitle: cardViewModel.emptyTitle,
                            isEmpty: isEmpty,
                            isLoading: isLoading,
                            title: cardViewModel.title,
                            type: (cardViewModel.cardRowViewModels?[0].image, cardViewModel.cardRowViewModels?[0].text),
                            accessibility: (cardViewModel.cardRowViewModels?[1].image, cardViewModel.cardRowViewModels?[1].text),
                            price: (cardViewModel.cardRowViewModels?[2].image, cardViewModel.cardRowViewModels?[2].text),
                            participants: (cardViewModel.cardRowViewModels?[3].image, cardViewModel.cardRowViewModels?[3].text))
    }
    
    func fetchNewActivity() {
        isLoading = true
        service.getActivity { [weak self] (activity) in
            if let unwrapedActivity = activity {
                self?.activity = unwrapedActivity
                self?.isEmpty = false
            } else {
                self?.isEmpty = true
            }
            self?.isLoading = false
        }
    }
    
    func clearView() {
        isEmpty = true
    }
    
}
