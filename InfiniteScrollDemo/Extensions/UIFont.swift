//
//  UIFont.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 23..
//

import UIKit

private let kHelvetica = "Helvetica"
private let kHelveticaBold = "Helvetica-Bold"

extension UIFont {
    class func helvetica(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: kHelvetica, size: size) ?? systemFont(ofSize: size)
    }

    class func helveticaBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: kHelveticaBold, size: size) ?? systemFont(ofSize: size)
    }
}
