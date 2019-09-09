//
//  ViewController.swift
//  TedioffMVVM
//
//  Created by Débora Oliveira on 01/09/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - ViewController

class ViewController: UIViewController {
    
    // MARK: - ViewModels

    let disposeBag = DisposeBag()
    var mainViewModel: MainViewModel = MainViewModel()
    
    // MARK: - View
    
    lazy var mainView: GetActivityView = {
        let view = GetActivityView(frame: .zero)
        return view
    }()
    
    // MARK: - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = mainView
        self.title = "MVVM + RxSwift"
        
        // Inputs
        mainView.newActivityButton.rx.tap
            .bind(to: mainViewModel.tappedNew)
            .disposed(by: disposeBag)
        
        mainView.clearButton.rx.tap
            .bind(to: mainViewModel.tappedClear)
            .disposed(by: disposeBag)
        
        // Outputs
        mainViewModel.newActivityButtonEnabled
            .bind(to: mainView.newActivityButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        mainViewModel.newActivityButtonTitle
            .bind(to: mainView.newActivityButton.rx.title())
            .disposed(by: disposeBag)
        
        mainViewModel.clearButtonEnabled
            .bind(to: mainView.clearButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        mainViewModel.clearButtonTitle
            .bind(to: mainView.clearButton.rx.title())
            .disposed(by: disposeBag)
        
        mainViewModel.isLoading
            .subscribe(onNext: { [weak self] isLoading in
                if isLoading {
                    self?.mainView.startLoading()
                } else {
                    self?.mainView.stopLoading()
                }
            })
            .disposed(by: disposeBag)
        
        // Card View
        mainViewModel.cardViewModel.title
            .bind(to: mainView.cardView.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        mainViewModel.cardViewModel.emptyTitle
            .bind(to: mainView.cardView.emptyLabel.rx.text)
            .disposed(by: disposeBag)
        
        mainViewModel.cardViewModel.emptyTitleIsHidden
            .bind(to: mainView.cardView.emptyLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        // Card Rows View
//        Observable
//        .combineLatest(mainViewModel.cardViewModel.getCardRow(with: .type).type,
//                       mainViewModel.cardViewModel.getCardRow(with: .type).text)
//        .bind(to: mainView.cardView.rx.cardRow)
//        .disposed(by: disposeBag)
        
        for i in 0..<4  {
            Observable
                .combineLatest(mainViewModel.cardViewModel.cardRowViewModels[i].type,
                               mainViewModel.cardViewModel.cardRowViewModels[i].text)
                .bind(to: mainView.cardView.rx.cardRow)
                .disposed(by: disposeBag)
        }
    
    }
}

private extension Reactive where Base: CardView {
    
    var cardRow: Binder<(ActivityAttributes, NSMutableAttributedString?)> {
        return Binder(base) { view, rowData in
            
            var imageName: String? = rowData.0.rawValue
            let value = rowData.1
            
            if value == nil { imageName = nil }
            
            switch rowData.0 {
                case .type:
                    view.typeRowView.setValues(imageName, value)
                case .accessibility:
                    view.accessibilityRowView.setValues(imageName, value)
                case .price:
                    view.priceRowView.setValues(imageName, value)
                case .participants:
                    view.participantsRowView.setValues(imageName, value)
            }
            
        }
    }
}
