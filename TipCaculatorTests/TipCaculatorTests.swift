//
//  TipCaculatorTests.swift
//  TipCaculatorTests
//
//  Created by yeonBlue on 2023/03/10.
//

import XCTest
import Combine
@testable import TipCaculator

final class TipCaculatorTests: XCTestCase {
    
    // class setup() - 모든 테스트가 실행되기 전에 한 번만 호출됩니다. 이 메소드는 테스트 클래스의 모든 테스트 메소드에 공통적인 상태를 설정하는 데 사용
    // setup() - 각 테스트 메소드가 실행되기 전에 호출. 이 메소드는 테스트 클래스의 모든 테스트 메소드에 공통적인 상태를 설정하는 데 사용
    
    // sut -> System Under Test - SUT은 테스트 대상이 되는 시스템을 의미
    private var sut: CalculatorVM!
    private var cancellables: Set<AnyCancellable>!
    private var logoViewTapSubject: PassthroughSubject<Void, Never>!
    private var audioPlayerService: MockAudioPlayerService!
    
    override func setUp() {
        audioPlayerService = MockAudioPlayerService()
        sut = .init(audioPlayerService: audioPlayerService)
        cancellables = Set<AnyCancellable>()
        logoViewTapSubject = .init()
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        logoViewTapSubject = nil
        cancellables = nil
        audioPlayerService = nil
    }
    
    func test_ResultWithOutTipForOnePerson() {
        
        // given
        let bill: Double = 100.0
        let tip: Tip = .none
        let split: Int = 1
        let input = buildInput(bill: bill, tip: tip, split: split)
        
        // when
        let output = sut.transform(input: input)
        
        // then
        output.updateViewPublisher
            .sink { result in
                XCTAssertEqual(result.amountPerPerson, 100)
                XCTAssertEqual(result.totalBill, 100)
                XCTAssertEqual(result.totalTip, 0)
            }.store(in: &cancellables)
    }
    
    func test_ResultWithoutTipFor2Person() {
        
        // given
        let bill: Double = 100.0
        let tip: Tip = .none
        let split: Int = 2
        let input = buildInput(bill: bill, tip: tip, split: split)
        
        // when
        let output = sut.transform(input: input)
        
        // then
        output.updateViewPublisher
            .sink { result in
                XCTAssertEqual(result.amountPerPerson, 50)
                XCTAssertEqual(result.totalBill, 100)
                XCTAssertEqual(result.totalTip, 0)
            }.store(in: &cancellables)
    }
    
    func test_ResultWith10PercentTipFor2Person() {
        
        // given
        let bill: Double = 100.0
        let tip: Tip = .tenPercent
        let split: Int = 2
        let input = buildInput(bill: bill, tip: tip, split: split)
        
        // when
        let output = sut.transform(input: input)
        
        // then
        output.updateViewPublisher
            .sink { result in
                XCTAssertEqual(result.amountPerPerson, 55)
                XCTAssertEqual(result.totalBill, 110)
                XCTAssertEqual(result.totalTip, 10)
            }.store(in: &cancellables)
    }
    
    func test_ResultWithCustomTipFor4Person() {
        
        // given
        let bill: Double = 200.0
        let tip: Tip = .custom(value: 201)
        let split: Int = 4
        let input = buildInput(bill: bill, tip: tip, split: split)
        
        // when
        let output = sut.transform(input: input)
        
        // then
        output.updateViewPublisher
            .sink { result in
                XCTAssertEqual(result.amountPerPerson, 100.25)
                XCTAssertEqual(result.totalBill, 401)
                XCTAssertEqual(result.totalTip, 201)
            }.store(in: &cancellables)
    }
    
    func test_SoundPlayedAndResetWhenLogoViewTap() {
        
        // given
        let input = buildInput(bill: 100, tip: .tenPercent, split: 2)
        let output = sut.transform(input: input)
        let expectation1 = XCTestExpectation(description: "reset calculator called")
        let expectation2 = audioPlayerService.expectaion
                
        // then
        output.resetCalculatorPublisher
            .sink { _ in
                expectation1.fulfill()
            }.store(in: &cancellables)
        
        // when
        logoViewTapSubject.send()
        wait(for: [expectation1, expectation2], timeout: 1.0)
    }
    
    private func buildInput(bill: Double, tip: Tip, split: Int) -> CalculatorVM.Input {
        return .init(billPublisher: Just(bill).eraseToAnyPublisher(),
                     tipPublisher: Just(tip).eraseToAnyPublisher(),
                     splitPublisher: Just(split).eraseToAnyPublisher(),
                     logoViewTapPublisher: logoViewTapSubject.eraseToAnyPublisher())
    }
}

class MockAudioPlayerService: AudioPlayerService {
    
    var expectaion = XCTestExpectation(description: "playSound is called")
    
    func playSound() {
        expectaion.fulfill()
    }
}

/// Unit Test는 비즈니스 로직을 테스트
/// Given: 테스트에 필요한 입력값과 초기 상태를 정의하는 부분입니다.
/// 예를 들어, 테스트 대상 객체의 인스턴스를 생성하고, 메소드의 인자로 전달할 값을 설정하는 코드가 이 부분에 위치합니다.
/// When: 테스트 대상 객체의 메소드를 호출하고, 그 결과를 저장하는 부분입니다.
/// 예를 들어, 테스트 대상 객체의 메소드를 호출하여 반환값을 얻거나, 객체의 상태가 변경되는지 확인하는 코드가 이 부분에 위치합니다.
/// Then: 테스트 결과가 예상한 값과 일치하는지 검증하는 부분입니다.
/// 예를 들어, XCTAssertEqual()과 같은 XCTest의 assertion 메소드를 사용하여 반환값이나 객체의 상태가 예상한 값과 일치하는지 확인하는 코드가 이 부분에 위치합니다.


