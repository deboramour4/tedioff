//
//  CardRowView.swift
//  TedioffMVC
//
//  Created by Débora Oliveira on 31/08/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

//
// MARK: - CardRowView
//
class CardRowView: UIView {
    //
    // MARK: - Variables
    //
    var image: UIImage?
    var text: String? {
        didSet {
            setLabelText()
        }
    }
    var isPrice: Bool?
    
    //
    // MARK: - UI elements
    //
    private lazy var imageView: UIImageView = {
        var image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        return image
    }()
    private lazy var label: UILabel = {
        var label = UILabel(frame: .zero)
        label.textColor = UIColor.black
        label.font = UIFont.primary
        label.numberOfLines = 1
        return label
    }()
    
    //
    // MARK: - Initializers
    // FIXME: A melhor forma de receber os dados é no init? Ou setando cada valor na variável? - label.font
    init(frame: CGRect, image: UIImage?) {
        super.init(frame: frame)
        self.image = image
        setup()
    }
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
        backgroundColor = UIColor.clear
        
        // FIXME: Qual é a melhor forma de setar esses dados? Aqui? didSet?
        imageView.image = image
        
        addViews()
    }
    override func didMoveToSuperview() {
        autoLayout()
    }
    private func addViews() {
        addSubview(imageView)
        addSubview(label)
    }
    private func autoLayout() {
        imageView.anchor(leading: leadingAnchor, top: topAnchor, bottom: bottomAnchor, padding: UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0))
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        label.anchor(leading: imageView.trailingAnchor, top: topAnchor, trailing: trailingAnchor, bottom: bottomAnchor, padding: UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0))
    }
    private func setLabelText(){
        guard let text = text else { return }
        
        if isPrice != nil {
            let value = Int(text) ?? 0
            
            let priceString = NSMutableAttributedString(string: "$$$$$", attributes: [NSAttributedString.Key.font: UIFont.primary ?? UIFont.systemFont(ofSize: 18)])
            priceString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.accent, range: NSRange(location: 0,length: value+1))
            label.attributedText = priceString
        } else {
            self.label.text = text.capitalized
        }
    }
   
}
