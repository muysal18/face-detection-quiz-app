//
//  LoginViewController.swift
//  Quiz
//
//  Created by Ulas Uysal on 15.04.2023.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController{
    
    
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userNameTextField.autocorrectionType = .no
        passwordTextField.autocorrectionType = .no
    }
    
    
    
    @IBAction func loginAction(_ sender: Any) {
        
        let userName: String
        let password: String
        userName = userNameTextField.text!
        password = passwordTextField.text!
        
        //May be added to usser helper or user delegate
        FirebaseAuth.Auth.auth().signIn(withEmail: userName, password: password, completion: {result, error in
            if error != nil{
                self.showCreateAccount(email: userName, password: password)
                return
                
            }else{
                print("You have signed in")
                self.moveForwardToNextPage()
            }
        })
    
        
    }
    
    //May be added to user helper or user delegate
    func showCreateAccount(email: String, password: String){
        let alert = UIAlertController(title: "Create Account", message: "Would you like to create an account", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: {_ in
            self.moveForwardToSignUpPage()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in}))
        present(alert, animated: true)
    }
    func moveForwardToSignUpPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController{
            self.navigationController?.pushViewController(viewController, animated: false)
        }
        
    }
    func moveForwardToNextPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "gameViewController") as? GameViewController{
            self.navigationController?.pushViewController(viewController, animated: false)
        }
        //self.performSegue(withIdentifier: "gameViewControllerSegue", sender: nil)
    }

}


