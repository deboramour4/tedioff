//
//  ViewController.swift
//  TedioffMVVM
//
//  Created by Débora Oliveira on 01/09/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var viewModel: MainViewModel = MainViewModel()
    
    // FIXME: Faz sentido a minha controller ter mais de um VM?
    var cardViewModel: CardViewModel = CardViewModel(api: Network.shared)
    
    lazy var mainView: View = {
        let view = View(frame: .zero)
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
        cardViewModel.updateLoadingStatus = {[weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.cardViewModel.isLoading ?? false
                if isLoading {
                    self?.mainView.startLoading()
                }else {
                    self?.mainView.stopLoading()
                }
            }
        }
        
        cardViewModel.updateActivity = { [weak self] () in
            DispatchQueue.main.async {
                
                self?.mainView.cardView.titleLabel.text = self?.cardViewModel.title
                
                self?.mainView.cardView.typeRowView.setValues(self?.cardViewModel.cardRowViewModels[0].image, self?.cardViewModel.cardRowViewModels[0].text)
                
                self?.mainView.cardView.accessibilityRowView.setValues(self?.cardViewModel.cardRowViewModels[1].image, self?.cardViewModel.cardRowViewModels[1].text)
                
                self?.mainView.cardView.priceRowView.setValues(self?.cardViewModel.cardRowViewModels[2].image, self?.cardViewModel.cardRowViewModels[2].text)
                
                self?.mainView.cardView.participantsRowView.setValues(self?.cardViewModel.cardRowViewModels[3].image, self?.cardViewModel.cardRowViewModels[3 ].text)
            }
        }
    }
    
}

extension ViewController: ViewDelegate {
    func didTapSearch() {
        cardViewModel.fetchNewActivity()
    }
}
