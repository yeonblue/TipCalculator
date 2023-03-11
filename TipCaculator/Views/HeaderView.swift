//
//  HeaderView.swift
//  TipCaculator
//
//  Created by yeonBlue on 2023/03/11.
//

import UIKit

class HeaderView: UIView {
    
    // MARK: - Properties
    private let topLabel: UILabel = {
        return LabelFactory.build(text: nil, font: ThemeFont.bold(size: 18))
    }()
    
    private let bottomLabel: UILabel = {
        return LabelFactory.build(text: nil, font: ThemeFont.regular(size: 16))
    }()
    
    private let topSpacerView = UIView()
    private let bottomSpacerView = UIView()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            topSpacerView,
            topLabel,
            bottomLabel,
            bottomSpacerView
        ])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = -4
        
        return stackView
    }()
    
    // MARK: - Init
    init() {
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
        
        topSpacerView.snp.makeConstraints {
            $0.height.equalTo(bottomSpacerView)
        }
    }
    
    // MARK: - SetUp
    func configure(topText: String, bottomText: String) {
        topLabel.text = topText
        bottomLabel.text = bottomText
    }
}
