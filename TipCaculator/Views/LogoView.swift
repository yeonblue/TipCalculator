//
//  LogoView.swift
//  TipCaculator
//
//  Created by yeonBlue on 2023/03/10.
//

import UIKit

class LogoView: UIView {
    
    // MARK: - Properties
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icCalculatorBW"))
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(
            string: "Mr TIP",
            attributes: [.font: ThemeFont.demibold(size: 16)]
        )
        text.addAttributes([.font: ThemeFont.bold(size: 24)], range: NSMakeRange(3, 3)) // 앞에서부터 3자 제외, 그 뒤로 3자만 적용(TIP)
        label.attributedText = text
        
        return label
    }()
    
    private let bottomLabel: UILabel = {
        return LabelFactory.build(text: "Calculator", font: ThemeFont.demibold(size: 20), textAlignment: .left)
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            vStackView
        ])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        
        return stackView
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            topLabel,
            bottomLabel
        ])
        stackView.axis = .vertical
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
    
    // MARK: - SetUp
    private func layout() {
        addSubview(hStackView)
        
        hStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.width.equalTo(imageView.snp.height)
        }
    }
}
