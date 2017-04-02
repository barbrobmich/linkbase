//
//  LoginViewController.swift
//  LinkBase
//
//  Created by Michael Leung on 3/30/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
	
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
    
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
	
	@IBAction func logIn(_ sender: Any) {
		PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!) { (user: PFUser?, error: Error?) in
			if user != nil {
              NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogIn), object: nil)
			//	self.performSegue(withIdentifier: "loginSegue", sender: nil)
			} else {
				print("unknown error occured!")
				self.alert(message: "Incorrect username or password")
			}
		}
	}
    
	@IBAction func createAccount(_ sender: Any) {
		self.performSegue(withIdentifier: "createSegue", sender: nil)	
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
