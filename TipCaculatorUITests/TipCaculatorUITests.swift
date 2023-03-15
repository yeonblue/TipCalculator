//
//  TipCaculatorUITests.swift
//  TipCaculatorUITests
//
//  Created by yeonBlue on 2023/03/10.
//

import XCTest
@testable import TipCaculator

final class TipCaculatorUITests: XCTestCase {

    private var app: XCUIApplication!
    private var screen: CalculatorScreen {
        return CalculatorScreen(app: app)
    }
    
    override func setUp() {
        super.setUp()
        app = .init()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    func test_ResultViewDefaultValues() {
        XCTAssertEqual(screen.amountPersonPerValueLabel.label, "$0")
        XCTAssertEqual(screen.totalBillValueLabel.label, "$0")
        XCTAssertEqual(screen.totalTipValueLabel.label, "$0")
    }
}
