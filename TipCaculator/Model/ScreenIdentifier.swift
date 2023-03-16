//
//  ScreenIdentifier.swift
//  TipCaculator
//
//  Created by yeonBlue on 2023/03/15.
//

import Foundation


/// UITest를 위한 accessibilityIdentifier를 정의
enum ScreenIdentifier {
    enum ResultView: String {
        case totalAmountPerPersonValueLabel
        case totalBillValueLabel
        case totalTipValueLabel
    }
    
    enum LogoView: String {
        case logoView
    }
    
    enum BillInputView: String {
        case textField
    }
    
    enum TipInputView: String {
        case tenPercentButton
        case fifteenPercentButton
        case twentyPercentButton
        case customTipButton
        case customTipAlertTextField
    }
    
    enum SplitInputView: String {
        case decrementButton
        case increaseButton
        case quantityValueLabel
    }
}
