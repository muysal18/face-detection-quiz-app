//
//  LeaderBoardViewController.swift
//  Quiz
//
//  Created by Ulas Uysal on 16.04.2023.
//
import FirebaseDatabase
import UIKit

class LeaderBoardViewController: UIViewController {
    @IBOutlet weak var userNameTextFiled: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    private let database = Database.database().reference()
    private var faceDetectionHelper = FaceDetectionHelper()
    private var userDataSource = UserDataSource()
    var cityArray : [User] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        resetTextField()
        userDataSource.delegate = self
        //userDataSource.getListOfCities()
        
        }
    
    @IBAction func addToDatabase(_ sender: Any) {
        let object: [String: Any] = [
            "userName": userNameTextFiled.text!,
            "score": FaceDetectionHelper.quizScorePoints
        ]
        database.child("leaderboard_\(Int.random(in: 0..<1000))").setValue(object)
        FaceDetectionHelper.quizScorePoints = 0
        resetTextField()
    }
    
    @IBAction func userInoutEdittingChanged(_ sender: Any) {
        if let userName = userNameTextFiled.text{
            if let errorMessage = invalidUserName(userName){
                errorLabel.text = errorMessage
                errorLabel.isHidden = false
            }else{
                errorLabel.isHidden = true
            }
        }
        checkForValidUsername()
    }
    func invalidUserName(_ value: String) -> String?
        {
            if value.count < 2
            {
                return "Username must be at least 2 characters"
            }
            if value.count > 15
            {
                return "Username must be lower than 15 characters"
            }
           
            return nil
        }
    
    func resetTextField(){
        addButton.isEnabled = false
        errorLabel.isHidden = false
        errorLabel.text = "Required"
        userNameTextFiled.text = ""
        
    }
    func checkForValidUsername(){
        if errorLabel.isHidden{
            addButton.isEnabled = true
        }else{
            addButton.isEnabled = false
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension LeaderBoardViewController: UITableViewDataSource{
   func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDataSource.getNumberOfCities()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? InfoTableViewCell else {
            return UITableViewCell()
        }

        if let user = userDataSource.getCity(for: indexPath.row) {
            cell.userNameLabel.text = user.userName
            cell.scoreLabel.text = "\(user.score)"
        } else {
            cell.scoreLabel.text = ""
        }
        
        return cell
    }

    
    
}
extension LeaderBoardViewController: UserDataDelegate{
    func userListLoaded() {
        self.tableView.reloadData()
    }
}
