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
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func exit(_ sender: Any) {
		navigationController?.popViewController(animated: true)
		dismiss(animated: true, completion: nil)
	}

	@IBAction func createAccount(_ sender: Any) {
		
		if passwordTextField.text != confirmPasswordTextField.text {
			alert(message: "Passwords do not match")
		}
		
		let user = PFUser()
		user.username = emailTextField.text
		user.password = passwordTextField.text
		
		user.signUpInBackground { (succeeded: Bool, error: Error?) in
			if let error = error {
				print("error: \(error)")
				self.alert(message: "Username already taken")
				// Show the errorString somewhere and let the user try again.
			} else {
				// Hooray! Let them use the app now.
				print("user created!")
				self.alert(message: "User created!")
			}
		}
	}
	
	func alert(message: String) {
		let alert = UIAlertController(title: "Alert", message: "\(message)", preferredStyle: UIAlertControllerStyle.alert)
		alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
		self.present(alert, animated: true, completion: nil)
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
