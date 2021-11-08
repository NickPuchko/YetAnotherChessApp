//
//  SFImage.swift
//  ChessApp
//
//  Created by Nikolai Puchko on 26.09.2021.
//

import SwiftUIX

extension UIImage {
	static func symbol(_ symbol: SFSymbolName) -> UIImage {
		UIImage(systemName: symbol.rawValue)
		?? UIImage(systemName: SFSymbolName.phone.rawValue)!
	}
}
