//
//  Tip.swift
//  TipCaculator
//
//  Created by yeonBlue on 2023/03/11.
//

import Foundation

enum Tip: CustomStringConvertible {
    case none
    case tenPercent
    case fifteenPercent
    case twentyPercent
    case custom(value: Int)
    
    var description: String {
        switch self {
        case .none:
            return ""
        case .tenPercent:
            return "10%"
        case .fifteenPercent:
            return "15%"
        case .twentyPercent:
            return "20%"
        case .custom(let value):
            return "\(value.description)%"
        }
    }
}
