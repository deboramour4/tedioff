//
//  CardView.swift
//  TedioffMVC
//
//  Created by Débora Oliveira on 31/08/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

// MARK: - CardView

class CardView: BaseView {
    
    // MARK: - UI elements
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont.title
        label.numberOfLines = 0
        return label
    }()
    // FIXME: Talvez fosse bom indexPath aqui
    private lazy var typeRowView: CardRowView = {
        var row = CardRowView(frame: .zero)
        return row
    }()
    private lazy var accessibilityRowView: CardRowView = {
        var row = CardRowView(frame: .zero)
        return row
    }()
    private lazy var priceRowView: CardRowView = {
        var row = CardRowView(frame: .zero)
        return row
    }()
    private lazy var participantsRowView: CardRowView = {
        var row = CardRowView(frame: .zero)
        return row
    }()
    
    // MARK: - Override methods
    
    override func initialize() {
        backgroundColor = UIColor.white
        clipsToBounds = true
        layer.cornerRadius = 16
    }
    override func addViews() {
        addSubview(titleLabel)
        addSubview(typeRowView)
        addSubview(accessibilityRowView)
        addSubview(priceRowView)
        addSubview(participantsRowView)
    }
    override func autoLayout() {
        titleLabel.anchor(leading: leadingAnchor, top: topAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 32, left: 16, bottom: 0, right: 16))
        
        typeRowView.anchor(leading: leadingAnchor, top: titleLabel.bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 32, left: 0, bottom: 0, right: 0))
        
        accessibilityRowView.anchor(leading: leadingAnchor, top: typeRowView.bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 32, left: 0, bottom: 0, right: 0))
        
        priceRowView.anchor(leading: leadingAnchor, top: accessibilityRowView.bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 32, left: 0, bottom: 0, right: 0))
        
        participantsRowView.anchor(leading: leadingAnchor, top: priceRowView.bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 32, left: 0, bottom: 0, right: 0))
    }
    
    func setViewValues(title: String?, type: (UIImage?, NSMutableAttributedString?), accessibility: (UIImage?, NSMutableAttributedString?), price: (UIImage?, NSMutableAttributedString?), participants: (UIImage?, NSMutableAttributedString?)) {
        self.titleLabel.text = title
        self.typeRowView.setValues(type.0, type.1)
        self.accessibilityRowView.setValues(accessibility.0, accessibility.1)
        self.priceRowView.setValues(price.0, price.1)
        self.participantsRowView.setValues(participants.0, participants.1)
    }
}
