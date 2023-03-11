//
//  CalcuatlorVC.swift
//  TipCaculator
//
//  Created by yeonBlue on 2023/03/10.
//

import UIKit
import SnapKit

class CalcuatlorVC: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
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
}

