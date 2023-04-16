//
//  QuestionDelegate.swift
//  Quiz
//
//  Created by Ulas Uysal on 10.04.2023.
//

import Foundation
protocol QuestionDelegate: AnyObject {
    func clearAfterDraw()
    func resetUI()
}
