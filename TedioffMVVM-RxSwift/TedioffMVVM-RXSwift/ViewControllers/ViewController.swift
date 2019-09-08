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
        
        // Rows
        mainViewModel.cardViewModel.cardRowViewModels[0].imageName
            .bind(to: mainView.cardView.rx.rowTypeImageName)
            .disposed(by: disposeBag)
        
        mainViewModel.cardViewModel.cardRowViewModels[0].text
            .bind(to: mainView.cardView.rx.type)
            .disposed(by: disposeBag)
    }
}

private extension Reactive where Base: CardView {
    var rowTypeImageName: Binder<String?> {
        return Binder(base) { view, name in
            view.typeRowView.setImage(named: name)
        }
    }
    var type: Binder<NSMutableAttributedString?> {
        return Binder(base) { view, value in
            view.typeRowView.setText(value)
        }
    }
}
