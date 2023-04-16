//
//  ViewController.swift
//  Quiz
//
//  Created by Ulas Uysal on 8.04.2023.
//

import UIKit
import SceneKit
import ARKit
import AVFoundation

class GameViewController: UIViewController,ARSCNViewDelegate {
    @IBOutlet weak var bottomLabel: UILabel!
    
    @IBOutlet weak var leaderBoardButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var nextQuestionButton: UIButton!
    @IBOutlet weak var topRightLabel: UILabel!
    @IBOutlet weak var topLeftLabel: UILabel!
    @IBOutlet weak var sceneView: ARSCNView!
    private let questionHelper = QuestionHelper.sharedInstance
    private var faceDetectionHelper = FaceDetectionHelper()
    private var yesBoxNode: SCNNode?
    private var noBoxNode: SCNNode?
    private var tempBottomLabel = ""
    private var tempTopLeftLabel = ""
    private var tempTopRightLabel = ""
    private var correctAnswer = ""
    private var timer: Timer?
    private var timeRemaining = 5
    private var isTimerEnded = false
    private var timeIsUpMusic: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextQuestionButton.setTitle("Start the Quiz", for: .normal)
        topLeftLabel.isHidden = true
        topRightLabel.isHidden = true
        bottomLabel.isHidden = true
        timerLabel.isHidden = true
        timerLabel.text = "\(timeRemaining)"
        nextQuestionButton.isHidden = false
        sceneView.delegate = self
        questionHelper.delegate = self
        leaderBoardButton.isHidden = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARFaceTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let faceMesh = ARSCNFaceGeometry(device: sceneView.device!)
        let node = SCNNode(geometry: faceMesh)
        let transparentMaterial = SCNMaterial()
        transparentMaterial.diffuse.contents = UIColor(white: 1.0, alpha: 0.0)
        node.geometry?.firstMaterial = transparentMaterial
        return node
    }
    
    @IBAction func drawButton(_ sender: Any) {
        stopTimer()
        drawQuestions()
        startTimer()
        faceDetectionHelper.isQuestionTrue = false
        faceDetectionHelper.questionAnswerdBool = false
        nextQuestionButton.isHidden = true
        isTimerEnded = false
        timerLabel.isHidden = false
        topLeftLabel.isHidden = false
        topRightLabel.isHidden = false
        bottomLabel.isHidden = false
    }
    func startTimer() {
        timeRemaining = 5
        timerLabel.text = "\(timeRemaining)"
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerDidFire(_:)), userInfo: nil, repeats: true)
    }
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func timerDidFire(_ timer: Timer) {
        timeRemaining -= 1
        timerLabel.text = "\(timeRemaining)"
        if timeRemaining <= 0 {
            let url = Bundle.main.url(forResource: "086424_small-realpoot106wav-37403", withExtension: "mp3")
            self.timeIsUpMusic = try! AVAudioPlayer(contentsOf: url!)
            self.timeIsUpMusic.play()
            stopTimer()
            self.faceDetectionHelper.questionAnswerdBool = true
            nextQuestionButton.isHidden = false
            isTimerEnded = true
            // handle timer expiration
        }
    }
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let faceAnchor = anchor as? ARFaceAnchor, let faceGeometry = node.geometry as? ARSCNFaceGeometry {
            faceGeometry.update(from: faceAnchor.geometry)
            let headTilt = faceDetectionHelper.readFaceExpression(from: faceAnchor, question: tempBottomLabel , choice1: tempTopLeftLabel, choice2: tempTopRightLabel, correct: correctAnswer, isTimerEnded: isTimerEnded)
            DispatchQueue.main.async {
                if headTilt.count > 0 {
                    if self.faceDetectionHelper.questionAnswerdBool == false{
                        self.bottomLabel.text = headTilt
                    }
                    
                }
                if self.faceDetectionHelper.questionAnswerdBool == true{
                    self.nextQuestionButton.isHidden = false
                    
                    if self.faceDetectionHelper.isQuestionTrue == false{
                        if self.isTimerEnded == true{
                            self.bottomLabel.text = "Your time is ended the correct answer was " + self.correctAnswer
                            
                        }else{
                            self.bottomLabel.text = "Wrong, next time"
                            self.stopTimer()
                            
                        }
                    }else if self.faceDetectionHelper.isQuestionTrue == true{
                        self.bottomLabel.text = "You got it"
                        self.stopTimer()
                        
                    }
                }else if self.faceDetectionHelper.questionAnswerdBool == false{
                    
                    self.nextQuestionButton.setTitle("Next Question", for: .normal)
                    if self.questionHelper.drawCount == 10{
                        self.nextQuestionButton.setTitle("Start Again", for: .normal)
                    }
                    
                    self.nextQuestionButton.isHidden = true
                }
                
            }
        }
    }
    func drawQuestions(){
        
        let question = questionHelper.drawQuestion()
        if let question{
            bottomLabel.text = question.question
            tempBottomLabel = bottomLabel.text!
            topLeftLabel.text = question.choice1
            tempTopLeftLabel = topLeftLabel.text!
            topRightLabel.text = question.choice2
            tempTopRightLabel = topRightLabel.text!
            correctAnswer = question.correctAnswer
            
        }
        
    }
    
    
    
}
extension GameViewController: QuestionDelegate{
    func clearAfterDraw() {
        nextQuestionButton.setTitle("Start Again", for: .normal)
        leaderBoardButton.isHidden = false
        print("clear after draw " + "\(FaceDetectionHelper.quizScorePoints)")
    }
    func resetUI() {
        nextQuestionButton.setTitle("Next Question", for: .normal)
        leaderBoardButton.isHidden = true
    }
}
