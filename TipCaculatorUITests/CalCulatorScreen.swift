//
//  CalCulatorScreen.swift
//  TipCaculator
//
//  Created by yeonBlue on 2023/03/15.
//

import XCTest
@testable import TipCaculator

class CalculatorScreen {
    
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    // MARK: - LogoView
    var logoView: XCUIElement {
        return app.otherElements[ScreenIdentifier.LogoView.logoView.rawValue]
    }
    
    // MARK: - Result View
    var totalAmountPerPersonValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultView.totalAmountPerPersonValueLabel.rawValue]
    }
    
    var totalBillValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultView.totalBillValueLabel.rawValue]
    }
    
    var totalTipValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultView.totalTipValueLabel.rawValue]
    }
    
    // MARK: - BillInputView
    var billInputViewTextField: XCUIElement {
        return app.textFields[ScreenIdentifier.BillInputView.textField.rawValue]
    }
    
    // MARK: - TipInputView
    var tenPercentTipButton: XCUIElement {
        return app.buttons[ScreenIdentifier.TipInputView.tenPercentButton.rawValue]
    }
    
    var fifteenTipButton: XCUIElement {
        return app.buttons[ScreenIdentifier.TipInputView.fifteenPercentButton.rawValue]
    }
    
    var twentyPercentTipButton: XCUIElement {
        return app.buttons[ScreenIdentifier.TipInputView.twentyPercentButton.rawValue]
    }
    
    var customTipButton: XCUIElement {
        return app.buttons[ScreenIdentifier.TipInputView.customTipButton.rawValue]
    }
    
    var customTipAlertTextField: XCUIElement {
        return app.textFields[ScreenIdentifier.TipInputView.customTipAlertTextField.rawValue]
    }
    
    // MARK: - SplitInputView
    var incrementButton: XCUIElement {
        return app.buttons[ScreenIdentifier.SplitInputView.increaseButton.rawValue]
    }
    
    var decrementButton: XCUIElement {
        return app.buttons[ScreenIdentifier.SplitInputView.decrementButton.rawValue]
    }
    
    var quantityValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.SplitInputView.quantityValueLabel.rawValue]
    }
    
    // MARK: - Actions
    func enterBill(amount: Double) {
        billInputViewTextField.tap()
        billInputViewTextField.typeText("\(amount)\n") // 키보드를 내리기 위해 \n 추가
    }
    
    func selectTip(tip: Tip) {
        switch tip {
            case .none:
                break
            case .tenPercent:
                tenPercentTipButton.tap()
            case .fifteenPercent:
                fifteenTipButton.tap()
            case .twentyPercent:
                twentyPercentTipButton.tap()
            case .custom(value: let value):
                customTipButton.tap()
                XCTAssertTrue(customTipAlertTextField.waitForExistence(timeout: 1.0))
                customTipAlertTextField.typeText("\(value)\n")
            }
    }
    
    func selectIncrementButton(numberOfTaps: Int) {
        incrementButton.tap(withNumberOfTaps: numberOfTaps, numberOfTouches: 1)
    }
    
    func selectDecrementButton(numberOfTaps: Int) {
        decrementButton.tap(withNumberOfTaps: numberOfTaps, numberOfTouches: 1)
    }
    
    func doubleTapLogoView() {
        logoView.tap(withNumberOfTaps: 2, numberOfTouches: 1)
    }
}
