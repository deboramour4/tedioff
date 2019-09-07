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

enum ViewStatus {
    case showing(Activity?)
    case loading
}

class Controller {
    enum Action {
        case confirm
    }
    
//    let disposeBag = DisposeBag()
    let viewController: ViewController
    let activityManager: ActivityManager
    
    lazy var action: Observable<Action> = {
        return self.viewController.confirm.map { .confirm }
    }()
    
    init(status: Observable<ViewStatus>,
         activityManager: ActivityManager = .init(),
         viewController: ViewController = .init()) {
        self.viewController = viewController
        self.activityManager = activityManager
        
        subscribe(toStatus: status)
        subscribe(toAction: action)
    }
    
    func subscribe(toStatus accountStatus: Observable<ViewStatus>) {
        accountStatus
            .subscribe(onNext: { [viewController] (status) in
                let viewModel = MainViewModel(status: status)
                viewController.bind(viewModel)
                print("changed status")
            })
//            .disposed(by: disposeBag)
    }
    
    func subscribe(toAction action: Observable<Action>) {
        action
            .flatMap ({ [activityManager] action -> Completable in
                switch action {
                case .confirm:
                    print("action tap button")
                    activityManager.getActivity({ (activity) in
                        AppDelegate.status.onNext(ViewStatus.showing(activity))
                    })
                    return .empty()
                }
            })
            .subscribe()
//            .disposed(by: disposeBag)
    }
}
