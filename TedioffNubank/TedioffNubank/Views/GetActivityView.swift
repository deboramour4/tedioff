//
//  View.swift
//  TedioffMVC
//
//  Created by Débora Oliveira on 30/08/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

// MARK: - GetActivityView

class GetActivityView: BaseView {
    
    // MARK: - UI elements
    
    lazy var newActivityButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.backgroundColor = UIColor.accent
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .disabled)
        button.titleLabel?.font = UIFont.button
        button.layer.cornerRadius = 16
        return button
    }()
    private lazy var backgroundView: UIView = {
        var view = UIView(frame: .zero)
        view.alpha = 0.0
        view.backgroundColor = UIColor.blackTransparent
        return view
    }()
    private lazy var indicatorView: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView(style: .whiteLarge)
        return indicator
    }()
    private lazy var cardView: CardView = {
        var card = CardView(frame: .zero)
        return card
    }()
    
    // MARK: - Overrides methods
    
    override func initialize() {
        backgroundColor = UIColor.primary
        newActivityButton.setTitle("New activity", for: .normal)
    }
    override func addViews() {
        addSubview(newActivityButton)
        addSubview(cardView)
        addSubview(backgroundView)
        addSubview(indicatorView)
    }
    override func autoLayout() {
        newActivityButton.anchor(leading: safeAreaLayoutGuide.leadingAnchor, top: safeAreaLayoutGuide.topAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 32, left: 16, bottom: 0, right: 16))
        
        cardView.anchor(leading: leadingAnchor, top: newActivityButton.bottomAnchor, trailing: trailingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        
        backgroundView.anchor(leading: leadingAnchor, top: topAnchor, trailing: trailingAnchor, bottom: bottomAnchor)
        
        indicatorView.centralize(in: self)
    }
    func startLoading() {
        UIView.animate(withDuration: 0.3) {
            self.backgroundView.alpha = 1.0
        }
        indicatorView.startAnimating()
    }
    func stopLoading() {
        UIView.animate(withDuration: 0.4) {
            self.backgroundView.alpha = 0.0
        }
        indicatorView.stopAnimating()
    }
    func getCardView() -> CardView {
        return self.cardView
    }
}
