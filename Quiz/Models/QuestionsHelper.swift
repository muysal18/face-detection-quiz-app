//
//  QuestionsHelper.swift
//  Quiz
//
//  Created by Ulas Uysal on 10.04.2023.
//

import Foundation
import Foundation
import SceneKit
import ARKit

class QuestionHelper {
    static let sharedInstance = QuestionHelper()
    private var questions: [Questions] = []
    public var drawCount = 0
    weak var delegate: QuestionDelegate?
    private var question = ""
    init(){
        
        createQuestions()
    }
    
    private func createQuestions(){
        questions = [
            
            Questions(id: 1, question: "What is the capital of Canada?", choice1: "Montreal", choice2: "Ottawa", correctAnswer: "Ottawa"),
            
            Questions(id: 2, question: "Who wrote the novel \"To Kill a Mockingbird\"?", choice1: "Harper Lee", choice2: "J.D. Salinger", correctAnswer: "Harper Lee"),
            
            Questions(id: 3, question: "Which planet is known as the \"Red Planet\"?", choice1: "Venus", choice2: "Mars", correctAnswer: "Mars"),
            
            Questions(id: 4, question: "Which country is the world's largest producer of coffee?", choice1: "Brazil", choice2: "Colombia", correctAnswer: "Brazil"),
            
            Questions(id: 5, question: "Which river is the longest in the world?", choice1: "Amazon", choice2: "Nile", correctAnswer: "Nile"),
            
            Questions(id: 6, question: "Who is the current CEO of Microsoft?", choice1: "Tim Cook", choice2: "Satya Nadella", correctAnswer: "Satya Nadella"),
            
            Questions(id: 7, question: "What is the smallest country in the world?", choice1: "Vatican City", choice2: "Monaco", correctAnswer: "Vatican City"),
            
            Questions(id: 8, question: "Which famous artist painted the \"Mona Lisa\"?", choice1: "Michelangelo", choice2: "Leonardo da Vinci", correctAnswer: "Leonardo da Vinci"),
            
            Questions(id: 9, question: "What is the highest mountain in the world?", choice1: "Mount Kilimanjaro", choice2: "Mount Everest", correctAnswer: "Mount Everest"),
            
            Questions(id: 10, question: "Which continent is the largest in size?", choice1: "Asia", choice2: "Africa", correctAnswer: "Asia"),
            
            Questions(id: 11, question: "What is the capital of Australia?", choice1: "Sydney", choice2: "Canberra", correctAnswer: "Canberra"),
            
            Questions(id: 12, question: "Is the creater of this app going to work in Codeway", choice1: "Yes", choice2: "No", correctAnswer: "Yes"),
            
            Questions(id: 13, question: "What is the largest ocean in the world?", choice1: "Atlantic Ocean", choice2: "Pacific Ocean", correctAnswer: "Pacific Ocean"),
            
            Questions(id: 14, question: "Who is the founder of Amazon?", choice1: "Jeff Bezos", choice2: "Bill Gates", correctAnswer: "Jeff Bezos"),
            
            Questions(id: 15, question: "What is the currency of Japan?", choice1: "Yen", choice2: "Won", correctAnswer: "Yen"),
            
            Questions(id: 16, question: "Which country is home to the famous architectural wonder, the Taj Mahal?", choice1: "India", choice2: "Thailand", correctAnswer: "India"),
            
            Questions(id: 17, question: "Who wrote the plays \"Romeo and Juliet\" and \"Hamlet\"?", choice1: "William Shakespeare", choice2: "Samuel Beckett", correctAnswer: "William Shakespeare"),
            
            Questions(id: 18, question: "Which is the highest mountain in Africa?", choice1: "Kilimanjaro", choice2: "Mount Everest", correctAnswer: "Kilimanjaro"),
            
            Questions(id: 19, question: "What is the world's largest desert?", choice1: "Sahara", choice2: "Arctic", correctAnswer: "Arctic"),
            
            Questions(id: 20, question: "Which continent is the most populous in the world?", choice1: "Asia", choice2: "Africa", correctAnswer: "Asia")
        ].shuffled()
        
        drawCount = 0
    }
    
    func drawQuestion() -> Questions?{
        drawCount += 1
        if drawCount > 10{
            FaceDetectionHelper.quizScorePoints = 0
            createQuestions()
            delegate?.resetUI()
            return nil
        }else if drawCount == 10 {
            delegate?.clearAfterDraw()
        }
        return questions.removeFirst()
    }
    
    
}
