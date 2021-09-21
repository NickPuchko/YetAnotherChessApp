//
//  TabBarAccessor.swift
//  TabBarAccessor
//
//  Created by Nikolai Puchko on 12.09.2021.
//

import SwiftUI

struct TabBarAccessor: UIViewControllerRepresentable {
	var callback: (UITabBar) -> Void
	private let proxyController = ViewController()

	func makeUIViewController(context: UIViewControllerRepresentableContext<TabBarAccessor>) ->
							  UIViewController {
		proxyController.callback = callback
		return proxyController
	}

	func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<TabBarAccessor>) {}

	typealias UIViewControllerType = UIViewController

	private class ViewController: UIViewController {
		var callback: (UITabBar) -> Void = { _ in }

		override func viewWillAppear(_ animated: Bool) {
			super.viewWillAppear(animated)
			if let tabBar = tabBarController {
				callback(tabBar.tabBar)
			}
		}
	}
}
