//
//  Blur.swift
//  ChessApp
//
//  Created by Nikolai Puchko on 26.09.2021.
//

import SwiftUI

struct Blur: UIViewRepresentable {
		var style: UIBlurEffect.Style = .systemMaterial

		func makeUIView(context: Context) -> UIVisualEffectView {
				return UIVisualEffectView(effect: UIBlurEffect(style: style))
		}

		func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
				uiView.effect = UIBlurEffect(style: style)
		}
}
