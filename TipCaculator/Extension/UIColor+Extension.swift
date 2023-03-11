//
//  UIColor+Extension.swift
//  TipCaculator
//
//  Created by yeonBlue on 2023/03/11.
//

import UIKit

extension UIColor {
    
    /// hex 값으로 UIColor를 생성
    ///
    /// ```
    ///  let darkGrey = UIColor(hexString: "757575")
    /// ```
    /// 자세한 설명은 [stackoverflow](https://stackoverflow.com/questions/24263007/how-to-use-hex-color-values/33397427#33397427) 참고
    /// - Parameter hexString: hex값 string 값.
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
