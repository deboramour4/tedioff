//
//  MainViewModel.swift
//  TedioffMVVM
//
//  Created by Débora Oliveira on 01/09/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

public class MainViewModel {
    
    private let activity: Activity
    
    private var cardViewModel: CardViewModel
    
    init(activity: Activity) {
        self.activity = activity
        self.cardViewModel = CardViewModel(activity: activity)
    }
    
    func configure(_ view: View) {
        view.cardView.viewModel = cardViewModel
    }
}
