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
    var languageCollections: [LanguageCollection] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentUser = User.current()
        print("Current user: \(currentUser.username!)")
        emailLabel.text = currentUser.email!
        
        fetchLanguageCollections()
        
        tableView.delegate = self
        tableView.dataSource = self
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
    
    
    // MARK: - FETCH PARSE ITEMS
    
    func fetchLanguageCollections() {
        
        var langCollection = LanguageCollection()
        
        let query = PFQuery(className: LanguageCollection.parseClassName())
        query.includeKey("affiliations")
        query.includeKey("projects")
        query.order(byDescending: "_created_at")
        query.whereKey("user_name", equalTo: currentUser.username!)
        query.limit = 20
        query.findObjectsInBackground { (matches: [PFObject]?, error: Error?) -> Void in
            
            if let myMatches = matches {
                print("Matched Items: \(myMatches)"
                )
                for match in myMatches {
                    if let match = match as? LanguageCollection {
                        langCollection = match
                        print("langcollection lang: \(langCollection.language_name!)")
                        self.languageCollections.append(langCollection)
                            if let affMatches = langCollection.affiliations {
                                var i = 0
                                for affiliation in affMatches{
                                    self.languageCollections[i].affiliations?.append(affiliation)
                                    i += 1
                                }
                        }
                            if let projMatches = langCollection.projects{
                                var i = 0
                                for proj in projMatches {
                                    self.languageCollections[i].projects?.append(proj)
                                    print("Project is: \(self.languageCollections[i].projects![0].name!)")
                                    i += 1
                                }
                            }
                    }
                    self.tableView.reloadData()
                    print("count of items in language collection: \(self.languageCollections.count)")
                }
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageCollections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileLanguageCell", for: indexPath) as! ProfileLanguageCell
        
        cell.languageNameLabel.text = self.languageCollections[indexPath.item].language_name
        cell.matchedItemsCount = (self.languageCollections[indexPath.item].affiliations?.count)! + (self.languageCollections[indexPath.item].projects?.count)!
//        if (self.languageCollections[indexPath.item].affiliations?.count)! > 0 {
//            print("affiliation name: \(self.languageCollections[indexPath.item].affiliations![0].name!)")
//        }
         cell.retrievedAffiliations = self.languageCollections[indexPath.item].affiliations!
         cell.retrievedProjects = self.languageCollections[indexPath.item].projects!
       
        return cell
    }
    

}
