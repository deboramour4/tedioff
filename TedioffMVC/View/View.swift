//
//  View.swift
//  TedioffMVC
//
//  Created by Débora Oliveira on 30/08/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

//
// MARK: - View
//
class View: UIView {
    //
    // MARK: - Variables and Delegates
    // FIXME: Isso ta certo?
    weak var delegate: ViewDelegate?
    var activityTitle: String? {
        didSet {
            cardView.title = activityTitle
        }
    }
    var activityType: String? {
        didSet {
            cardView.type = activityType
        }
    }
    var activityAccessibility: Float? {
        didSet {
            cardView.accessibility = activityAccessibility
        }
    }
    var activityPrice: Float? {
        didSet {
            cardView.price = activityPrice
        }
    }
    var activityParticipants: Int? {
        didSet {
            cardView.participants = activityParticipants
        }
    }
    
    //
    // MARK: - UI elements
    //
    private lazy var hatImage: UIImageView = {
        var image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "topHat")
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hatImageTapped)))
        return image
    }()
    //FIXME: A view pode ter uma referencia publica de cardView? Ou melhor deixar privado mesmo?
    private lazy var cardView: CardView = {
        var card = CardView(frame: .zero)
        return card
    }()
    
    //
    // MARK: - Initializers
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    //
    // MARK: - Class methods
    //
    private func setup() {
        backgroundColor = UIColor.primary
        addViews()
    }
    override func didMoveToSuperview() {
        setConstraints()
    }
    private func addViews() {
        addSubview(hatImage)
        addSubview(cardView)
    }
    private func setConstraints() {
        hatImage.anchor(leading: safeAreaLayoutGuide.leadingAnchor, top: safeAreaLayoutGuide.topAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        hatImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        
        cardView.anchor(leading: leadingAnchor, top: hatImage.bottomAnchor, trailing: trailingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
    }

    @objc private func hatImageTapped() {
        delegate?.didTapSearch()
    }
}

protocol ViewDelegate: class {
    func didTapSearch()
}
