//
//  ThemeFont.swift
//  TipCaculator
//
//  Created by yeonBlue on 2023/03/11.
//

import UIKit

struct ThemeFont {
    
    static func regular(size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Regular", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func bold(size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Bold", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func demibold(size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Demibold", size: size) ?? .systemFont(ofSize: size)
    }
}
