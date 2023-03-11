//
//  BillInputView.swift
//  TipCaculator
//
//  Created by yeonBlue on 2023/03/10.
//

import UIKit
import Combine
import CombineCocoa

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
    
    // AnyPublisher는 자신만의 속성이나 메서드가 없으며, Publisher 프로토콜에 정의된 것만 사용할 수 있다.
    // 따라서 AnyPublisher에 send(_:) 연산자와 같은 것은 존재하지 않는다.
    // 다른 모듈에서 사용할 때 퍼블리셔의 실제 타입을 알 필요가 없으므로, AnyPublisher로 감싸서 제공.
    // PassthroughSubject는 구독자가 없으면 값을 버리므로, PassthroughSubject를 직접 외부에 노출하면 원하는 값이 전달되지 않을 수 있음.
    // billSubject에 값을 보내는 것은 해당 클래스 내에서만 가능하지만, valuePublisher를 구독하는 것은 외부에서도 가능.
    
    private let billSubject: PassthroughSubject<Double, Never> = .init()
    var valuePublisher: AnyPublisher<Double, Never> {
        return billSubject.eraseToAnyPublisher()
    }
    
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        layout()
        observe()
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
    
    private func observe() {
        textField.textPublisher
            .compactMap { $0 }
            .sink { [unowned self] text in
                
                // 일반적으로, 클로저가 인스턴스보다 오래 살아남을 가능성이 있는 경우에는 weak self를 사용하고, 그렇지 않은 경우에는 unowned self를 사용
                // escaping closure 같이 클로저가 함수의 실행이 끝나도 남아있을 수 있을 땐 weak self를 사용
                billSubject.send(text.doubleValue)
            }
            .store(in: &cancellable)
    }
}
