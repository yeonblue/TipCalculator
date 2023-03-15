//
//  ResultView.swift
//  TipCaculator
//
//  Created by yeonBlue on 2023/03/10.
//

import UIKit
import SnapKit

class ResultView: UIView {
    
    // MARK: - Properties
    private let headerLabel: UILabel = {
        return LabelFactory.build(text: "Total p/person", font: ThemeFont.demibold(size: 18))
    }()
    
    private let amountPerPersonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let text = NSMutableAttributedString(
            string: "$0",
            attributes: [.font: ThemeFont.bold(size: 40)]
        )
        text.addAttributes([.font: ThemeFont.bold(size: 24)], range: NSMakeRange(0, 1)) // 맨 앞 $표시
        label.attributedText = text
        label.accessibilityIdentifier = ScreenIdentifier.ResultView.totalAmountPerPersonValueLabel.rawValue
        
        return label
    }()
    
    private let horizonLineView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.separator
        
        return view
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            headerLabel,
            amountPerPersonLabel,
            horizonLineView,
            buildSpacerView(height: 0), // spacing이 8로 되어있어서 height가 0이어도 어느정도 spacing이 생김
            hStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let totalBillView: AmountView = {
        return AmountView(title: "Total bill",
                          textAlignment: .left,
                          amountLabelIdentifier: ScreenIdentifier.ResultView.totalBillValueLabel.rawValue)
    }()
    
    private let totalTipView: AmountView = {
        return AmountView(title: "Total tip",
                          textAlignment: .right,
                          amountLabelIdentifier: ScreenIdentifier.ResultView.totalTipValueLabel.rawValue)
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            totalBillView,
            UIView(),
            totalTipView
        ])
        stackView.axis = .horizontal
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
    private func layout() {
        backgroundColor = .white
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(24)
        }
        
        horizonLineView.snp.makeConstraints {
            $0.height.equalTo(2)
        }
        
        addShadow(offset: CGSize(width: 0, height: 4), color: .black, radius: 12.0, opacity: 0.2)
    }
    
    private func buildSpacerView(height: CGFloat) -> UIView {
        let view = UIView()
        view.snp.makeConstraints {
            $0.height.equalTo(height)
        }
        
        return view
    }
    
    func configure(result: CalculatorResult) {
        let text = NSMutableAttributedString(
            string: String(result.amountPerPerson.currencyFormatted),
            attributes: [.font: ThemeFont.bold(size: 48)]
        )
        text.addAttributes([.font: ThemeFont.bold(size: 24)], range: NSMakeRange(0, 1))
        amountPerPersonLabel.attributedText = text
        
        totalBillView.configure(amount: result.totalBill)
        totalTipView.configure(amount: result.totalTip)
    }
}
