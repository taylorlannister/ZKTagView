//
//  UIColor+Extension.swift
//  TagViewDemo
//
//  Created by 刘志康 on 2019/12/20.
//  Copyright © 2019 刘志康. All rights reserved.
//

import UIKit

class UIColor_Extension {
    //随机颜色
    static func randomColor() -> UIColor {
        return UIColor.init(red: CGFloat.random(in: 0 ... 255), green: CGFloat.random(in: 0 ... 255), blue: CGFloat.random(in: 0 ... 255), alpha: 1)
    }
}
