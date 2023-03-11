//
//  LabelFactory.swift
//  TipCaculator
//
//  Created by yeonBlue on 2023/03/11.
//

import UIKit

struct LabelFactory {
    
    /// 편하게 UILabel을 생성하기 위한 static 함수
    /// - Parameters:
    ///   - text: Label Text
    ///   - font: Label Font
    ///   - textColor: 텍스트 색
    ///   - backgroundColor: Label Background
    ///   - textAlignment: 정렬 방식
    /// - Returns: UILabel
    static func build(
        text: String?,
        font: UIFont,
        textColor: UIColor = ThemeColor.text,
        backgroundColor: UIColor = .clear,
        textAlignment: NSTextAlignment = .center
    ) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.backgroundColor = backgroundColor
        label.textAlignment = textAlignment
        
        return label
    }
}
