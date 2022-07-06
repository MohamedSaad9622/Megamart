//
//  Login_ViewController.swift
//  Megamart
//
//  Created by MAC on 01/07/2022.
//

import UIKit

class Login_ViewController: UIViewController {

    @IBOutlet weak var signUp_button: UIButton!
    @IBOutlet weak var signIn_button: UIButton!
    @IBOutlet weak var userPassword_textField: UITextField!
    @IBOutlet weak var userEmail_textField: UITextField!
    @IBOutlet weak var signInView: UIView!
    @IBOutlet weak var backgroundView: UIView!

    var login_viewModel: Login_protocol = Login_modelView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInView.layer.cornerRadius = 30
        backgroundView.layer.cornerRadius = 30
        
        login_viewModel.binding = {loggedin, error in
            if let error = error {
                addAlert(title: "Warning", message: error, ActionTitle: "Try Again", viewController: self)
            }
            if loggedin {
                addAlert(title: "Done", message: "", ActionTitle: "Try Again", viewController: self)
//                let storyBoard : UIStoryboard = UIStoryboard(name: Constants.Main_storyboard, bundle:nil)
//                let favoritesViewController = storyBoard.instantiateViewController(withIdentifier: Constants.HomeViewController_id) as! HomeViewController
//                self.navigationController?.pushViewController(favoritesViewController, animated: true)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        login_viewModel.retriveAllCustomer()
    }
    
    
    @IBAction func signin(_ sender: Any) {
        if checkIs_NotEmpty() {
            if let email = userEmail_textField.text, let  password = userPassword_textField.text{
                login_viewModel.login(userName: email, password: password)
            }
            print("Not empty")
        }else{
            print("empty")
        }
        
        
    }
    
    @IBAction func signup(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.SignUp_viewController_id) {
            self.navigationController?.show(vc, sender: self)
        }
    }

    func checkIs_NotEmpty() -> Bool {

        if userEmail_textField.text!.isEmpty {
            addAlert(title: "Warning", message: "Please enter your Email", ActionTitle: "Try Again", viewController: self)
            return false
        }
        if userPassword_textField.text!.isEmpty {
            addAlert(title: "Warning", message: "Please enter your password", ActionTitle: "Try Again", viewController: self)
            return false
        }

        return true
    }
}
