//
//  ProfileViewController.swift
//  LinkBase
//
//  Created by Michael Leung on 3/30/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit
import Parse


class ProfileViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var weirdFactLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    
    var currentUser: User!
    var firstName: String!
    var lastName: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentUser = User.current()
        print("Current user: \(currentUser.username!)")
        
        
        emailLabel.text = currentUser.email!
        
    }
    
    // MARK: - IB ACTIONS
    
    @IBAction func onLogout(_ sender: UIButton) {
        print("Tapped on logout")
        User.logOut()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogout), object: nil)
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
