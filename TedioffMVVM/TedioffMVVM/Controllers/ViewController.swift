//
//  ViewController.swift
//  TedioffMVVM
//
//  Created by Débora Oliveira on 01/09/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

// MARK: - ViewController

class ViewController: UIViewController {
    
    // MARK: - ViewModels

    var viewModel: MainViewModel = MainViewModel()
    
    var cardViewModel: CardViewModel = CardViewModel(api: Network.shared)
    
    lazy var mainView: GetActivityView = {
        let view = GetActivityView(frame: .zero)
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = mainView
        self.title = "MVVM"
                
        initVM()
    }
    
    func initVM() {
        cardViewModel.updateLoadingStatus = { [weak self] in
            DispatchQueue.main.async {
                let isLoading = self?.cardViewModel.isLoading ?? false
                if isLoading {
                    self?.mainView.startLoading()
                } else {
                    self?.mainView.stopLoading()
                }
            }
        }
        
        cardViewModel.updateActivity = { [weak self] in
            DispatchQueue.main.async {
                self?.cardViewModel.configure(self?.mainView.getCardView())
            }
        }
    }
    
}

// MARK: - ViewDelegate

extension ViewController: GetActivityViewDelegate {
    func didTapSearch() {
        cardViewModel.fetchNewActivity()
    }
}
