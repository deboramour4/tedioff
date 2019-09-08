//
//  CardViewModel.swift
//  TedioffMVVM
//
//  Created by Débora Oliveira on 01/09/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - CardViewModel

class CardViewModel {
    
    // MARK: - Variables
    
    private let disposeBag = DisposeBag()
    
    //Inputs
    public let activity = PublishSubject<Activity?>()
    
    //Outputs
    public let title: Observable<String?>
    public let type: Observable<String?>
    public let accessibility: Observable<String?>
    public let price: Observable<String?>
    public let participants: Observable<String?>
    public let emptyTitleIsHidden: Observable<Bool>
    public let emptyTitle: Observable<String>
    
    public let cardRowViewModels: [CardRowViewModel]

    // MARK: - Initializers
    
    init() {
        cardRowViewModels = [CardRowViewModel(), CardRowViewModel(), CardRowViewModel(), CardRowViewModel()]
    
        emptyTitle = .just("Nothing to show")
        
        emptyTitleIsHidden = activity
            .map { $0 == nil ? false : true }
        
        title = activity
            .map { return $0?.activity }
        
        type = activity
            .map { $0?.type.rawValue.capitalized }
        
        accessibility = activity
            .map { $0?.accessibility.description }
        
        price = activity
            .map { $0 != nil ? Int($0!.price * 4).description : nil }

        participants = activity
            .map {
                guard let activity = $0 else { return nil }
                
                if activity.participants == 1 {
                    return activity.participants.description + " participant"
                } else {
                    return activity.participants.description + " participants"
                }
            }
        
        // update row data from
        
        
    }
}
