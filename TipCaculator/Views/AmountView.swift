//
//  AmountView.swift
//  TipCaculator
//
//  Created by yeonBlue on 2023/03/11.
//

import UIKit

class AmountView: UIView {
    
    // MARK: - Properties
    private let title: String
    private let textAlignment: NSTextAlignment
    private let amountLabelIdentifier: String
    
    private lazy var titleLabel: UILabel = {
        return LabelFactory.build(text: title,
                                  font: ThemeFont.regular(size: 18),
                                  textColor: ThemeColor.text,
                                  textAlignment: textAlignment)
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = textAlignment
        label.textColor = ThemeColor.primary
        let text = NSMutableAttributedString(
            string: "$0",
            attributes: [.font: ThemeFont.bold(size: 24)]
        )
        
        text.addAttributes([.font: ThemeFont.bold(size: 16)], range: NSMakeRange(0, 1))
        label.attributedText = text
        label.accessibilityIdentifier = amountLabelIdentifier
        
        return label
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            amountLabel
        ])
        stackView.axis = .vertical
        
        return stackView
    }()
    
    // MARK: - Init
    init(title: String, textAlignment: NSTextAlignment, amountLabelIdentifier: String) {
        self.title = title
        self.textAlignment = textAlignment
        self.amountLabelIdentifier = amountLabelIdentifier
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Functions
    func configure(amount: Double) {
        let text = NSMutableAttributedString(string: amount.currencyFormatted, attributes: [.font: ThemeFont.bold(size: 24)])
        text.addAttributes([.font: ThemeFont.bold(size: 16)], range: NSMakeRange(0, 1))
        amountLabel.attributedText = text
    }
}
