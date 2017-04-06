//
//  LanguagesViewController.swift
//  LinkBase
//
//  Created by Barbara Ristau on 4/3/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit

class LanguagesViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentUser = User.current()

        let navigationBar = navigationController!.navigationBar
        navigationBar.tintColor = UIColor.blue
        
        let submitButton = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(LanguagesViewController.didTapSubmit))
        let nextButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.plain, target: self, action: #selector(LanguagesViewController.goToProfile))

        navigationItem.rightBarButtonItems = [nextButton, submitButton]
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = "Languages"
    }
    
    func goToProfile() {
        print("Going to Profile")
        self.performSegue(withIdentifier: "Profile", sender: self)
    }
    
    func didTapSubmit() {
        print("Submitting Match Data")
        
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

extension LanguagesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1

    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = UITableViewCell()  
    
    switch indexPath.section {
    case 0:
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "PickLanguageCell", for: indexPath) as! PickLanguageCell
        return cell1

    case 1:
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "AffProjCell", for: indexPath) as! AffProjCell
            cell2.cellSection = 1
        return cell2
        
    case 2:
        let cell3 = tableView.dequeueReusableCell(withIdentifier: "AffProjCell", for: indexPath) as! AffProjCell
            cell3.cellSection = 2
        return cell3
        
    case 3:
        let cell4 = tableView.dequeueReusableCell(withIdentifier: "AffProjCell", for: indexPath) as! AffProjCell
            cell4.cellSection = 3
        return cell4
        
    default:
        break
    }


    return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      
        
        switch section {
        case 0:
            return "Select Language"
        case 1:
            return "Matched Affiliations & Projects"
        case 2:
            return "Affiliations"
        case 3:
            return "Projects"
        default:
            break
        }
        return nil
    }

}

