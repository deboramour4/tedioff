//
//  MainViewModel.swift
//  TedioffMVVM
//
//  Created by Débora Oliveira on 01/09/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - MainViewModel

class MainViewModel {
    
    // MARK: - Variables

    private let disposeBag = DisposeBag()
    private let service: ActivityManager
    
    // Inputs UI
    public let tappedNew = PublishRelay<Void>()
    public let tappedClear = PublishRelay<Void>()
    
    // Inputs Network
    public let activity = PublishSubject<Activity?>()
    
    // Outputs
    public let newActivityButtonTitle: Observable<String>
    public let clearButtonTitle: Observable<String>
    public let newActivityButtonEnabled: Observable<Bool>
    public let clearButtonEnabled: Observable<Bool>
    public let isLoading: Observable<Bool>
    public let cardViewModel: CardViewModel
    
    // MARK: - Initializers
    
    init(service: ActivityManager = ActivityManager()) {
        self.service = service
        
        newActivityButtonTitle = .just("New activity")
        clearButtonTitle = .just("Clear")
        
        cardViewModel = CardViewModel(activity: activity)
        
        isLoading = Observable.merge(
            tappedNew.map { true },
            activity.map { _ in false })
                
        newActivityButtonEnabled = isLoading
            .map { $0 == true ? false : true }
            .startWith(true)

        clearButtonEnabled = Observable.merge(
            isLoading.map { $0 == true ? false : true },
            activity.map { $0 == nil ? false : true })
            .startWith(false)
        
        tappedNew
            .subscribe(onNext: { [weak self] _ in
                self?.fetchNewActivity()
            })
            .disposed(by: disposeBag)

        tappedClear
            .subscribe(onNext: { [weak self] _ in
                self?.activity.onNext(nil)
            })
            .disposed(by: disposeBag)
    }
    
    // Return activity here?
    func fetchNewActivity() {
        service.getActivity { [weak self] (activity) in
            self?.activity.onNext(activity)
        }
    }
    
}
