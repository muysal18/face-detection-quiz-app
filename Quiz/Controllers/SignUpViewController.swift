//
//  SignUpViewController.swift
//  Quiz
//
//  Created by Ulas Uysal on 15.04.2023.
//

import UIKit
import FirebaseAuth

class SignupViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailTextField.autocorrectionType = .no
        passwordTextField.autocorrectionType = .no
        repeatPasswordTextField.autocorrectionType = .no
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func signUpAcction(_ sender: Any) {
        let userName: String
        let password: String
        let repeatPassword: String
        userName = emailTextField.text!
        password = passwordTextField.text!
        repeatPassword = repeatPasswordTextField.text!
        if password == repeatPassword {
            FirebaseAuth.Auth.auth().createUser(withEmail: userName, password: password, completion: {result, error in
                guard error == nil else{
                    let alert = UIAlertController(title: "Failed to Create an Account", message: "Invalid Email", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {_ in}))
                    self.present(alert, animated: true)
                    print("not a valid email")
                    return
                }
                print("You have signed in")
                self.moveForwardToLogInPage()
            })
        }else{
            let alertPassword = UIAlertController(title: "Failed to Create an Account", message: "Passwords are not matching", preferredStyle: .alert)
            alertPassword.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {_ in}))
            present(alertPassword, animated: true)
        }
    }
    func moveForwardToLogInPage() {
        let alertPassword = UIAlertController(title: "Account Created", message: "You Have Sucsesfully Created an Account", preferredStyle: .alert)
        alertPassword.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {_ in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        present(alertPassword, animated: true)
        
    }
    
}
