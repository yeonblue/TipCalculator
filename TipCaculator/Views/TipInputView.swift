//
//  TipInputView.swift
//  TipCaculator
//
//  Created by yeonBlue on 2023/03/10.
//

import UIKit
import Combine
import CombineCocoa

class TipInputView: UIView {
    
    // MARK: - Properties
    private let headerView: HeaderView = {
        let headerView = HeaderView()
        headerView.configure(topText: "Choose", bottomText: "your tip")
        
        return headerView
    }()
    
    private lazy var tenPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .tenPercent)
        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.tenPercentButton.rawValue
        button.tapPublisher
            .flatMap { Just(Tip.tenPercent) }
            .assign(to: \.value, on: tipSubject) // sink 클로저 안에 tipSubject.send(.twentyPercent) 보다 간결
            .store(in: &cancellable)
        
        return button
    }()
    
    private lazy var fifteenPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .fifteenPercent)
        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.fifteenPercentButton.rawValue
        button.tapPublisher
            .flatMap { Just(Tip.fifteenPercent) }
            .assign(to: \.value, on: tipSubject)
            .store(in: &cancellable)
        
        return button
    }()
    
    private lazy var twentyPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .twentyPercent)
        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.twentyPercentButton.rawValue
        button.tapPublisher
            .flatMap { Just(Tip.twentyPercent) }
            .assign(to: \.value, on: tipSubject)
            .store(in: &cancellable)
        
        return button
    }()
    
    private lazy var customPercentTipButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Custom tip", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(size: 20)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.addCornerRadius(radius: 8.0)
        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.customTipButton.rawValue
        button.tapPublisher
            .sink { [weak self] _ in
                self?.handleCustomTipButton()
            }
            .store(in: &cancellable)
        
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
            customPercentTipButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private var cancellable = Set<AnyCancellable>()
    private let tipSubject = CurrentValueSubject<Tip, Never>(.none)
    var valuePublisher: AnyPublisher<Tip, Never> {
        return tipSubject.eraseToAnyPublisher()
    }
    
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
    
    // MARK: - Functions
    private func handleCustomTipButton() {
        let alertController = UIAlertController(title: "Enter custom tip", message: nil, preferredStyle: .alert)
        alertController.addTextField { tf in
            tf.placeholder = "Make it generous!"
            tf.keyboardType = .numberPad
            tf.autocorrectionType = .no
            tf.accessibilityIdentifier = ScreenIdentifier.TipInputView.customTipAlertTextField.rawValue
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let ok = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let text = alertController.textFields?.first?.text,
                  let value = Int(text) else {
                return
            }
            
            self?.tipSubject.send(.custom(value: value))
        }
        
        [ok, cancel].forEach(alertController.addAction(_:))
        parentViewController?.present(alertController, animated: true)
    }
    
    private func resetView() {
        [tenPercentTipButton, fifteenPercentTipButton, twentyPercentTipButton, customPercentTipButton].forEach {
            $0.backgroundColor = ThemeColor.primary
            
        }
        
        let text = NSMutableAttributedString(string: "Custom tip", attributes: [.font: ThemeFont.bold(size: 20)])
        customPercentTipButton.setAttributedTitle(text, for: .normal)
    }
    
    private func observe() {
        tipSubject.sink { [unowned self] tip in
            resetView()
            
            switch tip {
                case .none:
                    break
                case .tenPercent:
                    tenPercentTipButton.backgroundColor = ThemeColor.secondary
                case .fifteenPercent:
                    fifteenPercentTipButton.backgroundColor = ThemeColor.secondary
                case .twentyPercent:
                    twentyPercentTipButton.backgroundColor = ThemeColor.secondary
                case .custom(let value):
                    customPercentTipButton.backgroundColor = ThemeColor.secondary
                    let text = NSMutableAttributedString(string: "$\(value)", attributes: [.font: ThemeFont.bold(size: 20)])
                    text.addAttributes([.font: ThemeFont.bold(size: 14)], range: NSMakeRange(0, 1))
                    customPercentTipButton.setAttributedTitle(text, for: .normal)
                }
        }
        .store(in: &cancellable)
    }
    
    func reset() {
        tipSubject.send(.none)
    }
}
