//
//  Controller.swift
//  TedioffNubank
//
//  Created by Débora Oliveira on 05/09/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

// MARK: - ViewStatus

enum ViewStatus {
    case showing(Activity)
    case loading
    case empty
}

// MARK: - Controller

class Controller {
    
    // MARK: - Action Enum
    
    enum Action {
        case confirm
        case clear
    }
    
    // MARK: - Variables
    
//    let disposeBag = DisposeBag()
    let viewController: ViewController
    let activityManager: ActivityManager
    
    lazy var action: Observable<Action> = {
        return self.viewController.confirm.map { .confirm }
    }()
    
    // MARK: - Initialization
    
    init(status: Observable<ViewStatus>,
         activityManager: ActivityManager = .init(),
         viewController: ViewController = .init()) {
        self.viewController = viewController
        self.activityManager = activityManager
        
        subscribe(toStatus: status)
        subscribe(toAction: action)
    }
    
    // MARK: - Subscribers
    
    func subscribe(toStatus accountStatus: Observable<ViewStatus>) {
        accountStatus
            .subscribe(onNext: { [viewController] (status) in
                let viewModel = MainViewModel(status: status)
                viewController.bind(viewModel)
            })
//            .disposed(by: disposeBag)
    }
    
    func subscribe(toAction action: Observable<Action>) {
        action
            .flatMap ({ [activityManager] action -> Completable in
                switch action {
                case .confirm:
                    AppDelegate.status.onNext(.loading)
                    activityManager.getActivity({ (activity) in
                        if let activity = activity {
                            AppDelegate.status.onNext(ViewStatus.showing(activity))
                        } else {
                            AppDelegate.status.onNext(ViewStatus.empty)
                        }
                    })
                    return .empty()
                case .clear:
                    AppDelegate.status.onNext(ViewStatus.empty)
                    return .empty()
                }
            })
            .subscribe()
//            .disposed(by: disposeBag)
    }
}
