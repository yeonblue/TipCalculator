//
//  ViewModelType.swift
//  TipCaculator
//
//  Created by yeonBlue on 2023/03/11.
//

import Foundation
import Combine

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var cancellables: Set<AnyCancellable> { get }
    
    func transform(input: Input) -> Output
}
