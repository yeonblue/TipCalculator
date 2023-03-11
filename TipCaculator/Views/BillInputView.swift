//
//  BillInputView.swift
//  TipCaculator
//
//  Created by yeonBlue on 2023/03/10.
//

import UIKit

class BillInputView: UIView {
    
    // MARK: - Properties
    private let headerView: HeaderView = {
        let headerView = HeaderView()
        headerView.configure(topText: "Enter", bottomText: "your bill")
        
        return headerView
    }()
    
    private let textFieldContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addCornerRadius(radius: 8.0)
        
        return view
    }()
    
    private let currencyDenominationLabel: UILabel = {
        let label = LabelFactory.build(text: "$", font: ThemeFont.bold(size: 24))
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal) // 우선순위로 인해 크기가 변하지 않도록 high로 CH를 설정
        
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = ThemeFont.demibold(size: 28)
        textField.keyboardType = .decimalPad
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textField.tintColor = ThemeColor.text // 커서의 색상이나 외곽 색을 변경
        textField.textColor = ThemeColor.text // text 자체 색상
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 36))
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        toolbar.items = [
            UIBarButtonItem(systemItem: .flexibleSpace),
            doneButton
        ]
        toolbar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolbar
        
        return textField
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
        [headerView, textFieldContainerView].forEach {
            addSubview($0)
        }
        
        headerView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalTo(textFieldContainerView.snp.centerY)
            $0.width.equalTo(68)
            $0.height.equalTo(36)
            $0.trailing.equalTo(textFieldContainerView.snp.leading).offset(-24)
        }
        
        textFieldContainerView.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
        }
        
        textFieldContainerView.addSubview(currencyDenominationLabel)
        textFieldContainerView.addSubview(textField)
        
        currencyDenominationLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        textField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(currencyDenominationLabel.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    
    @objc private func doneButtonTapped() {
        // textField.resignFirstResponder()는 현재 텍스트 필드가 첫 번째 응답자 상태를 가지고 있을 때 사용합니다.
        // endEditing(true)는 뷰 계층에서 모든 서브뷰에 대해 endEditing을 호출하는 메서드입니다.
        // 이 메서드는 텍스트 필드의 참조를 모르거나 여러 개의 텍스트 필드가 있을 때 사용할 수 있습니다. true 파라미터는 강제로 편집을 종료하도록 합니다.
        // endEditing(false)는 true와 비슷하지만, false 파라미터는 강제로 편집을 종료하지 않고 현재 편집 중인 뷰에게 선택권을 줍니다
        
        // view.endEditing(true), reference를 쥐고 있으면 textField.resignFirstResponder()를 사용
        textField.resignFirstResponder()
    }
}
