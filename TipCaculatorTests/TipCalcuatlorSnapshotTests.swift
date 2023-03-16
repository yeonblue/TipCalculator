//
//  TipCalcuatlorSnapshotTests.swift
//  TipCaculatorTests
//
//  Created by yeonBlue on 2023/03/15.
//

import XCTest
import SnapshotTesting
@testable import TipCaculator

final class TipCalcuatlorSnapshotTests: XCTestCase {

    private var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    func test_LogoView() {
        
        // given
        let size = CGSize(width: screenWidth, height: 48)
        
        // when
        let view = LogoView()
        
        // then
        assertSnapshots(matching: view, as: [.image(size: size)])
    }
    
    func test_InitResultView() {
        
        // given
        let size = CGSize(width: screenWidth, height: 224)
        
        // when
        let view = ResultView()
        
        // then
        assertSnapshots(matching: view, as: [.image(size: size)])
    }
    
    func test_InitTipInputView() {
        
        // given
        let size = CGSize(width: screenWidth, height: 56 + 16 + 56)
        
        // when
        let view = TipInputView()
        
        // then
        assertSnapshots(matching: view, as: [.image(size: size)])
    }
    
    func test_ResultViewWithValues() {
        
        // given
        let size = CGSize(width: screenWidth, height: 224)
        let result = CalculatorResult(amountPerPerson: 100.25, totalBill: 45, totalTip: 60)
        
        // when
        let view = ResultView()
        view.configure(result: result)
        
        // then
        assertSnapshots(matching: view, as: [.image(size: size)])
    }
    
    func test_BillInputViewWithValues() {
        
        // given
        let size = CGSize(width: screenWidth, height: 56)
        
        // when
        let view = BillInputView()
        let textField = view.allSubViewsOf(type: UITextField.self).first
        textField?.text = "500"
        
        // then
        assertSnapshots(matching: view, as: [.image(size: size)])
    }
    
    func test_TipInputViewWithValeus() {
        
        // given
        let size = CGSize(width: screenWidth, height: 56 + 16 + 56)
        
        // when
        let view = TipInputView()
        let button = view.allSubViewsOf(type: UIButton.self).first
        button?.sendActions(for: .touchUpInside)
        
        // then
        assertSnapshots(matching: view, as: [.image(size: size)])
    }
    
    func test_SplitInputViewWithSelection() {
        
        // given
        let size = CGSize(width: screenWidth, height: 56)
        
        // when
        let view = SplitInputView()
        let button = view.allSubViewsOf(type: UIButton.self).last // +를 누르기 위함
        button?.sendActions(for: .touchUpInside)
        
        // then
        assertSnapshots(matching: view, as: [.image(size: size)])
    }
}

/// Record로 저장된 SnapShot과 달라지면, Snapshot Test는 실패
/// record 파라미터를 true로 주면 스크린샷을 update
/// SnapShot Test는 iOS 앱의 뷰나 레이어를 캡쳐하고 저장된 참조 이미지와 비교하는 유닛 테스트 방법.
/// SnapShot Test를 사용하면 뷰의 디자인이나 레이아웃이 예상대로 나오는지 쉽게 확인할 수 있습니다.
/// SnapShot Test의 장점은 뷰의 변화를 시각적으로 파악할 수 있고, 코드로 테스트하기 어려운 뷰의 속성을 테스트할 수 있다.
/// 단점은 참조 이미지가 많아지면 저장 공간이 커지고, 테스트 실행 시간이 길어지고, 환경에 따라 테스트 결과가 달라질 수 있다.

extension UIView {
    
    // This is the function to get subViews of a view of a particular type
    func subViews<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        for view in self.subviews {
            if let aView = view as? T{
                all.append(aView)
            }
        }
        return all
    }
    
    /// This is a function to get subViews of a particular type from view recursively. It would look recursively in all subviews and return back the subviews of the type T
    func allSubViewsOf<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T{
                all.append(aView)
            }
            guard view.subviews.count > 0 else { return }
            view.subviews.forEach{ getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }
}
