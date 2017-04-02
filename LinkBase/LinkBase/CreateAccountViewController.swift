//
//  CreateAccountViewController.swift
//  LinkBase
//
//  Created by Michael Leung on 3/30/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit
import Parse

class CreateAccountViewController: UIViewController {

	@IBOutlet weak var firstNameTextField: UITextField!
	@IBOutlet weak var lastNameTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var confirmPasswordTextField: UITextField!
    
    var currentUser: User?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - USER SET UP METHODS
    func createUser(completion: (_ success: Bool) -> Void) {

        currentUser = User(_email: emailTextField.text!, _password: passwordTextField.text!, firstname: firstNameTextField.text!, lastname: lastNameTextField.text!)
        completion (true)

    }
    
    
    
	@IBAction func exit(_ sender: Any) {
		navigationController?.popViewController(animated: true)
		dismiss(animated: true, completion: nil)
	}

	@IBAction func createAccount(_ sender: Any) {

        // MOVE THIS TO A VALIDATION FUNCTION.  IF VALIDATE IS SUCCESSFUL THEN WE CAN DO THE SUBSEQUENT STEPS
//		if passwordTextField.text != confirmPasswordTextField.text {
//			alert(message: "Passwords do not match")
//		}
        

        createUser{ (success) -> Void in
            
            if success {
                
                currentUser!.signUpInBackground { (succeeded: Bool, error: Error?) in
                 if let error = error {
                     print("error: \(error)")
                    //				self.alert(message: "Username already taken")
                    //				// Show the errorString somewhere and let the user try again.
                    } else {
                    print("user created!")
                    self.alert(message: "User created!")
                }
              }
             }
            }
	}
	
	func alert(message: String) {
		let alert = UIAlertController(title: "Alert", message: "\(message)", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {_ in self.goToProfile(currUser: self.currentUser!)
        }))
		self.present(alert, animated: true, completion: nil)
	}
    
    func goToProfile(currUser: PFUser){
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidSignUp), object: nil)
    }
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
