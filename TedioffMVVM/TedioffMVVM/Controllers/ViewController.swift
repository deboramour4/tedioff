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

    var mainViewModel: MainViewModel = MainViewModel()
    
    // MARK: - View
    
    lazy var mainView: GetActivityView = {
        let view = GetActivityView(frame: .zero)
        view.delegate = self
        return view
    }()
    
    // MARK: - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = mainView
        self.title = "MVVM"
                
        initVM()
    }
    
    func initVM() {
        mainViewModel.updateLoadingStatus = { [weak self] (isLoading) in
            DispatchQueue.main.async {
                if isLoading {
                    self?.mainView.startLoading()
                } else {
                    self?.mainView.stopLoading()
                }
            }
        }
        
        mainViewModel.updateEmptyStatus = { [weak self] in
            DispatchQueue.main.async {
                self?.mainViewModel.configure(self?.mainView)
            }
        }
        
        self.mainViewModel.configure(self.mainView)
    }
    
}

// MARK: - ViewDelegate

extension ViewController: GetActivityViewDelegate {
    func getNewActivity() {
        mainViewModel.fetchNewActivity()
    }
    
    func clearActivity() {
        mainViewModel.clearView()
    }
}
