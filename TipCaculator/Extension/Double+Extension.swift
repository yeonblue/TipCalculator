//
//  Double+Extension.swift
//  TipCaculator
//
//  Created by yeonBlue on 2023/03/12.
//

import Foundation

extension Double {
    var currencyFormatted: String {
        
        /// 정수인지 아닌지 체크
        var isWholeNumber: Bool {
            // isZero: 0인지 아닌지
            // isNormal: 값이 정상적인 부동소수점 수인지 아닌지를 확인합니다. 값이 비정상적인 경우(예: 무한대나 NaN) false를 반환
            // self와 rounded()의 결과가 같으면 값이 정수라는 뜻이므로 true를 반환하고, 다르면 false를 반환.
            
            // 대신 Int(exactly:)를 쓸 수도 있음
            // 이는 부동소수점 수를 정수로 변환하는 생성자. 하지만 값이 정확하게 표현될 수 있는 경우에만 성공하고, 그렇지 않으면 nil을 반환한다.
            // 예를 들어, 21.0은 정수로 표현될 수 있으므로 Int(exactly: 21.0)은 21을 반환하지만, 21.5는 정수로 표현될 수 없으므로 nil을 반환
            
            isZero ? true : !isNormal ? false: self == rounded()
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US") // 언어코드 + 국가코드므로 미국은 en_US
        formatter.maximumFractionDigits = isWholeNumber ? 0 : 2
        return formatter.string(for: self) ?? ""
    }
}
