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
    
    // Inputs
    public let tappedNew = PublishRelay<Void>()
    public let tappedClear = PublishRelay<Void>()
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
        
        //FiXME: É assim mesmo?
        newActivityButtonTitle = .just("New activity")
        clearButtonTitle = .just("Clear")
        cardViewModel = CardViewModel()
        
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
        
        // FIXME: actions. map?
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
        
        
        activity
            .startWith(nil)
            .subscribe(onNext: { [weak self] (new) in
                self?.cardViewModel.activity.onNext(new)
            })
            .disposed(by: disposeBag)
    
    }
    
    // return activity here?
    func fetchNewActivity() {
        service.getActivity { [weak self] (activity) in
            self?.activity.onNext(activity)
        }
    }
    
}
