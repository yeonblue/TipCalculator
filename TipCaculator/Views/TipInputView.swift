//
//  TipInputView.swift
//  TipCaculator
//
//  Created by yeonBlue on 2023/03/10.
//

import UIKit

class TipInputView: UIView {
    
    // MARK: - Properties
    private let headerView: HeaderView = {
        let headerView = HeaderView()
        headerView.configure(topText: "Choose", bottomText: "your tip")
        
        return headerView
    }()
    
    private lazy var tenPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .tenPercent)
        
        return button
    }()
    
    private lazy var fifteenPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .fifteenPercent)
        
        return button
    }()
    
    private lazy var twentyPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .twentyPercent)
        
        return button
    }()
    
    private lazy var custoPercentTipButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Custom tip", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(size: 20)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.addCornerRadius(radius: 8.0)
        
        return button
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            tenPercentTipButton,
            fifteenPercentTipButton,
            twentyPercentTipButton
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        return stackView
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            hStackView,
            custoPercentTipButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        
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
    
    private func buildTipButton(tip: Tip) -> UIButton {
        
        // UIButton(type: .system)은 시스템 스타일의 버튼으로 내비게이션 바나 툴바에 보이는 버튼과 같다. 이 버튼은 시스템 틴트 색상을 사용하고 눌렀을 때 반응한다.
        // UIButton()과 UIButton(type: .custom)과 동일하며 외관이나 동작을 직접 설정해야 함
        let button = UIButton(type: .custom)
        button.backgroundColor = ThemeColor.primary
        button.addCornerRadius(radius: 8.0)
        // button.tintColor = .white // NSMutableAttributedString를 사용하므로 먹히지 않음
        
        let text = NSMutableAttributedString(
            string: tip.description,
            attributes: [.font: ThemeFont.bold(size: 20),
                         .foregroundColor: UIColor.white]
        )
        
        text.addAttributes([.font: ThemeFont.demibold(size: 14)], range: NSMakeRange(2, 1)) // 10, 15, 20%므로 앞의 두자리빼고 %만 적용
        button.setAttributedTitle(text, for: .normal)
        
        return button
    }
    
    private func layout() {
        [headerView, vStackView].forEach(addSubview(_:))
        
        vStackView.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
        }
        
        headerView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(vStackView.snp.leading).offset(-24)
            $0.width.equalTo(68)
            $0.centerY.equalTo(hStackView.snp.centerY)
        }
    }
}
