//
//  CalculatorVM.swift
//  TipCaculator
//
//  Created by yeonBlue on 2023/03/11.
//

import UIKit
import Combine

class CalculatorVM: ViewModelType {

    struct Input {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
    }
    
    struct Output {
        let updateViewPublisher: AnyPublisher<CalculatorResult, Never>
    }
    
    var cancellables = Set<AnyCancellable>()
    
    func transform(input: Input) -> Output {
        
        let result = CalculatorResult(amountPerPerson: 500, totalBill: 1000, totalTip: 2)
        return Output(updateViewPublisher: Just(result).eraseToAnyPublisher())
    }
}
