//
//  Primitives.swift
//  ChessApp
//
//  Created by Nikolai Puchko on 18.09.2021.
//
import Foundation

typealias Action = () -> ()

func onMainThread(_ block: @escaping () -> Void) {
	if Thread.isMainThread {
		block()
	} else {
		DispatchQueue.main.async(execute: block)
	}
}
