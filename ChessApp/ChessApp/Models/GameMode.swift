//
//  GameMode.swift
//  GameMode
//
//  Created by Nikolai Puchko on 11.09.2021.
//

enum GameMode: String, Codable, CaseIterable {
	case classic = "Классика"
	case rapid = "Рапид"
	case blitz = "Блиц"
	case bullet = "Пуля"
	case fide = "Классика FIDE"
	case chess960 = "Шахматы 960"
}
