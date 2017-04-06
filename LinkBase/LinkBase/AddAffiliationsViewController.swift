//
//  AddAffiliationsViewController.swift
//  LinkBase
//
//  Created by Barbara Ristau on 4/1/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit
import Parse

class AddAffiliationsViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false

        currentUser = User.current()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.reloadData()
        navigationItem.title = "Affiliations"
        navigationItem.rightBarButtonItem?.title = "Next"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
        //self.automaticallyAdjustsScrollViewInsets = false
        
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        if segue.identifier == "AddNew" {
            let destinationVC = segue.destination as! AddNewTableViewController
            destinationVC.navigationItem.title = "Add New Affiliation"
        }
        
        // this one is not yet functional
        else if segue.identifier == "Edit" {
            let destinationVC = segue.destination as! AddNewTableViewController
            destinationVC.navigationItem.title = "Edit Affiliation"
        }
    }
    
}

extension AddAffiliationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AffiliationsCell", for: indexPath) as! AffiliationsCell
        
        if indexPath.section == 0 {
            cell.cellSection = 1
        } else {
            cell.cellSection = 2
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (section%2 == 0) ? "My Affiliations":"Categories"
    }
    

}
