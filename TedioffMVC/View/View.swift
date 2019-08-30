//
//  View.swift
//  TedioffMVC
//
//  Created by Débora Oliveira on 30/08/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

class View: UIView {

    weak var delegate: ViewDelegate?
    
    lazy var hatImage: UIImageView = {
        var image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "topHat")
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hatImageTapped)))
        return image
    }()
    lazy var activityLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
//    lazy var findButton: UIButton = {
//        var button = UIButton(frame: .zero)
//        button.setTitle("Search", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = UIColor.orange
//        button.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
//        return button
//    }()
    lazy var questionInput: UITextField = {
        var textfield = UITextField(frame: .zero)
        textfield.font = UIFont.boldSystemFont(ofSize: 28)
        textfield.placeholder = "What's your question?"
        textfield.textColor = UIColor.black
        return textfield
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    func setup() {
        backgroundColor = UIColor.purple
        addViews()
    }
    override func didMoveToSuperview() {
        setConstraints()
    }
    func addViews() {
        addSubview(hatImage)
        addSubview(activityLabel)
    }
    func setConstraints() {
        hatImage.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        hatImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        
        activityLabel.anchor(top: hatImage.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
    }

    @objc func hatImageTapped() {
        delegate?.didTapSearch()
    }
    
}

protocol ViewDelegate: class {
    func didTapSearch()
}
