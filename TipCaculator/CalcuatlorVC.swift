//
//  CalcuatlorVC.swift
//  TipCaculator
//
//  Created by yeonBlue on 2023/03/10.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

class CalcuatlorVC: UIViewController {

    // MARK: - Properties
    private let logoView = LogoView()
    private let resultView = ResultView()
    private let billInputView = BillInputView()
    private let tipInputView = TipInputView()
    private let splitInputView = SplitInputView()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            logoView,
            resultView,
            billInputView,
            tipInputView,
            splitInputView,
            UIView() // spacer용으로 추가
            
        ])
        stackView.axis = .vertical
        stackView.spacing = 32
        return stackView
    }()
    
    private let vm = CalculatorVM()
    private var cancellable = Set<AnyCancellable>()
    
    private lazy var viewTapPublisher: AnyPublisher<Void, Never> = {
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        view.addGestureRecognizer(tapGesture)
        
        return tapGesture.tapPublisher.flatMap { _ in
            Just(())
        }.eraseToAnyPublisher()
    }()
    
    private lazy var logoDoubleTapPublisher: AnyPublisher<Void, Never> = {
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        tapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(tapGesture)
        
        return tapGesture.tapPublisher.flatMap { _ in
            Just(())
        }.eraseToAnyPublisher()
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bindViewModel()
        observe()
    }
    
    // MARK: - Setup
    private func layout() {
        view.backgroundColor = ThemeColor.background
        view.addSubview(vStackView)

        vStackView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        logoView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        
        resultView.snp.makeConstraints {
            $0.height.equalTo(224)
        }
        
        
        billInputView.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        
        tipInputView.snp.makeConstraints {
            $0.height.equalTo(56 + 16 + 56) // 버튼 + 16 + 버튼(56) 넓이가 될 예정
        }
        
        
        splitInputView.snp.makeConstraints {
            $0.height.equalTo(56)
        }
    }
    
    private func observe() {
        viewTapPublisher.sink { [unowned self] _ in
            view.endEditing(true)
        }.store(in: &cancellable)
    }
    
    private func bindViewModel() {
        let input = CalculatorVM.Input(
            billPublisher: billInputView.valuePublisher,
            tipPublisher: tipInputView.valuePublisher,
            splitPublisher: splitInputView.valuePublisher,
            logoViewTapPublisher: logoDoubleTapPublisher
        )
        
        let output = vm.transform(input: input)
        
        output.updateViewPublisher
            .sink { [unowned self] result in
                resultView.configure(result: result)
            }
            .store(in: &cancellable)
        
        output.resetCalculatorPublisher
            .sink { _ in
                print("reset form!")
            }.store(in: &cancellable)
    }
}

