//
//  SplitInputView.swift
//  TipCaculator
//
//  Created by yeonBlue on 2023/03/10.
//

import UIKit
import SnapKit

class SplitInputView: UIView {
    
    // MARK: - Properties
    private let headerView: HeaderView = {
        let headerView = HeaderView()
        headerView.configure(topText: "Split", bottomText: "the total")
        
        return headerView
    }()
    
    private lazy var decrementButton: UIButton = {
        let button = buildButon(text: "-", corners: [.layerMinXMaxYCorner, .layerMinXMinYCorner])
        
        return button
    }()
    
    private lazy var incrementButton: UIButton = {
        let button = buildButon(text: "+", corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        
        return button
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = LabelFactory.build(text: "1", font: ThemeFont.bold(size: 20), backgroundColor: .white)
        
        return label
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            decrementButton,
            quantityLabel,
            incrementButton
        ])
        stackView.axis = .horizontal
        stackView.spacing = 0
        
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
        [headerView, hStackView].forEach(addSubview(_:))
        
        hStackView.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
        }
        
        [incrementButton, decrementButton].forEach { button in
            button.snp.makeConstraints {
                $0.width.equalTo(button.snp.height)
            }
        }
        
        headerView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(hStackView.snp.leading).offset(-24)
            $0.width.equalTo(68)
        }
    }
    
    /// -, + 버튼 제작 builder 함수
    /// - Parameters:
    ///   - text: title text
    ///   - corners: 둥그렇게 할 특정 모서리
    private func buildButon(text: String, corners: CACornerMask) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = ThemeFont.bold(size: 20)
        button.addRoundedCorners(corners: corners, radius: 8.0)
        button.backgroundColor = ThemeColor.primary
        
        return button
    }
}
