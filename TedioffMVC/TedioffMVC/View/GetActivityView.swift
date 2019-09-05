//
//  View.swift
//  TedioffMVC
//
//  Created by Débora Oliveira on 30/08/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

// MARK: - GetActivityView

class GetActivityView: UIView {
    
    // MARK: - Variables and Delegates
    
    weak var delegate: GetActivityViewDelegate?
    
    // MARK: - UI elements

//    private lazy var hatImage: UIImageView = {
//        var image = UIImageView(frame: .zero)
//        image.contentMode = .scaleAspectFit
//        image.image = UIImage(named: "topHat")
//        image.isUserInteractionEnabled = true
//        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hatImageTapped)))
//        return image
//    }()
    private lazy var newActivityButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.backgroundColor = UIColor.accent
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.button
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(newActivitybuttonTapped), for: .touchUpInside)
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
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Class methods
    
    private func setup() {
        backgroundColor = UIColor.primary
        newActivityButton.setTitle("New activity", for: .normal)
        addViews()
    }
    override func didMoveToSuperview() {
        autoLayout()
    }
    private func addViews() {
//        addSubview(hatImage)
        addSubview(newActivityButton)
        addSubview(cardView)
        addSubview(backgroundView)
        addSubview(indicatorView)
    }
    private func autoLayout() {
//        hatImage.anchor(leading: safeAreaLayoutGuide.leadingAnchor, top: safeAreaLayoutGuide.topAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
//        hatImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        
        newActivityButton.anchor(leading: safeAreaLayoutGuide.leadingAnchor, top: safeAreaLayoutGuide.topAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 32, left: 16, bottom: 0, right: 16))
        
        cardView.anchor(leading: leadingAnchor, top: newActivityButton.bottomAnchor, trailing: trailingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, padding: UIEdgeInsets(top: 32, left: 16, bottom: 16, right: 16))
        
        backgroundView.anchor(leading: leadingAnchor, top: topAnchor, trailing: trailingAnchor, bottom: bottomAnchor)
        
        indicatorView.centralize(in: self)
    }
    func setViewValues(with activity: Activity?) {
        if let activity = activity {
            self.cardView.setViewValues(with: activity)
        }
    }
    @objc private func hatImageTapped() {
        delegate?.didTapSearch()
    }
    @objc private func newActivitybuttonTapped() {
        delegate?.didTapSearch()
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
}

protocol GetActivityViewDelegate: class {
    func didTapSearch()
}
