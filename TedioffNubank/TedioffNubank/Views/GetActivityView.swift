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
        button.setTitleColor(UIColor.grayLighter, for: .highlighted)
        button.setTitleColor(UIColor.gray, for: .disabled)
        button.titleLabel?.font = UIFont.button
        button.layer.cornerRadius = 16
        return button
    }()
    lazy var clearButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.grayLighter, for: .highlighted)
        button.setTitleColor(UIColor.gray, for: .disabled)
        button.titleLabel?.font = UIFont.button
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
        addSubview(clearButton)
        addSubview(cardView)
        addSubview(backgroundView)
        addSubview(indicatorView)
    }
    override func autoLayout() {
        newActivityButton.anchor(leading: safeAreaLayoutGuide.leadingAnchor, top: safeAreaLayoutGuide.topAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 32, left: 16, bottom: 0, right: 16))
        
        cardView.anchor(leading: leadingAnchor, top: newActivityButton.bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        
        clearButton.anchor(leading: leadingAnchor, top: cardView.bottomAnchor, trailing: trailingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0))
        
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
    
    func setViewValues(newActivityButtonIsEnabled: Bool, newActivityButtonTitle: String,
                       clearButtonIsEnabled: Bool, clearButtonTitle: String,
                       emptyTitleIsHidden: Bool, emptyTitle: String?,
                       isLoading: Bool,
                       title: String?,
                       type: (UIImage?, NSMutableAttributedString?),
                       accessibility: (UIImage?, NSMutableAttributedString?),
                       price: (UIImage?, NSMutableAttributedString?),
                       participants: (UIImage?, NSMutableAttributedString?)) {
        
        newActivityButton.isEnabled = newActivityButtonIsEnabled
        newActivityButton.setTitle(newActivityButtonTitle, for: .normal)
        clearButton.isEnabled = clearButtonIsEnabled
        clearButton.setTitle(clearButtonTitle, for: .normal)
        
        isLoading ? startLoading() : stopLoading()
        
        cardView.setViewValues(emptyTitleIsHidden: emptyTitleIsHidden, emptyTitle: emptyTitle, title: title, type: type, accessibility: accessibility, price: price, participants: participants)
    }
    
}
