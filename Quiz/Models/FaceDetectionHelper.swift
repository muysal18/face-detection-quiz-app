//
//  FaceDetectionHelper.swift
//  Quiz
//
//  Created by Ulas Uysal on 8.04.2023.
//

import Foundation
import SceneKit
import ARKit

class FaceDetectionHelper {
    private let questionHelper = QuestionHelper.sharedInstance
    public var questionAnswerdBool = true
    static public var quizScorePoints = 0
    private var correctMusic: AVAudioPlayer!
    private var wrongMusic: AVAudioPlayer!
    
    
    
    public var isQuestionTrue = false
    func readFaceExpression(from anchor: ARFaceAnchor, question: String, choice1: String, choice2: String, correct: String, isTimerEnded: Bool) -> String {
        //Burdaki bottomText gidebilir başka yere
        let bottomText = question
        
        let faceTransform = anchor.transform
        
        let leftRightAngle = simd_dot(faceTransform.columns.0, [1, -1, 0, 0])
        if isTimerEnded == false && questionAnswerdBool == false{
            if leftRightAngle < 0.6 {
                if(choice1 == correct){
                    questionAnswerdBool = true
                    isQuestionTrue = true
                    FaceDetectionHelper.quizScorePoints += 10
                    let url = Bundle.main.url(forResource: "short-applause-96213", withExtension: "mp3")
                    correctMusic = try! AVAudioPlayer(contentsOf: url!)
                    correctMusic.play()
                    //print(FaceDetectionHelper.quizScorePoints)
                }else if(choice1 != correct){
                    questionAnswerdBool = true
                    isQuestionTrue = false
                    let url = Bundle.main.url(forResource: "buzzer-or-wrong-answer-20582", withExtension: "mp3")
                    wrongMusic = try! AVAudioPlayer(contentsOf: url!)
                    wrongMusic.play()
                }
            } else if leftRightAngle > 1.2 {
                if(choice2 == correct){
                    questionAnswerdBool = true
                    isQuestionTrue = true
                    FaceDetectionHelper.quizScorePoints += 10
                    let url = Bundle.main.url(forResource: "short-applause-96213", withExtension: "mp3")
                    correctMusic = try! AVAudioPlayer(contentsOf: url!)
                    correctMusic.play()
                    //print(FaceDetectionHelper.quizScorePoints)
                }else if(choice2 != correct){
                    questionAnswerdBool = true
                    isQuestionTrue = false
                    let url = Bundle.main.url(forResource: "buzzer-or-wrong-answer-20582", withExtension: "mp3")
                    wrongMusic = try! AVAudioPlayer(contentsOf: url!)
                    wrongMusic.play()
                }
            }
        }
        return bottomText
    }
    
    
    
}

