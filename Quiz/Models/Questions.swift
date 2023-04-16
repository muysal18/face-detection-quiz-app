//
//  Questions.swift
//  Quiz
//
//  Created by Ulas Uysal on 10.04.2023.
//

import Foundation
struct Questions: Codable{
    let id: Int
    let question: String
    let choice1: String
    let choice2: String
    let correctAnswer: String
}
