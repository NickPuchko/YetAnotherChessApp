//
//  UINavigationBarAppearance.swift
//  UINavigationBarAppearance
//
//  Created by Nikolai Puchko on 14.09.2021.
//

import UIKit

extension UINavigationBarAppearance {
    static let withoutSeparator = UINavigationBarAppearance().then { appearance in
        appearance.shadowColor = nil
    }
}
