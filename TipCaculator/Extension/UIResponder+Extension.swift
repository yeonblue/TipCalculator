//
//  UIResponder+Extension.swift
//  TipCaculator
//
//  Created by yeonBlue on 2023/03/12.
//

import UIKit

extension UIResponder {
    
    /// 현재 View의 Parent UIViewController를 조회
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
