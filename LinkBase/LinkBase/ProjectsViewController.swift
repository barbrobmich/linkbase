//
//  ProjectsViewController.swift
//  LinkBase
//
//  Created by Barbara Ristau on 4/2/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!

    
    var currentUser: User!

    override func viewDidLoad() {
        super.viewDidLoad()

        currentUser = User.current()

        tableView.dataSource = self
        tableView.delegate = self
        
        let navigationBar = navigationController!.navigationBar
        navigationBar.tintColor = UIColor.blue
        
        let rightButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ProjectsViewController.goToLanguages))

        navigationItem.rightBarButtonItem = rightButton
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = "Projects"
    
        
    }
    
    func goToLanguages() {
    
        print("Go to Language VC")
        performSegue(withIdentifier: "Languages", sender: self)
    
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

extension ProjectsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectsCell", for: indexPath) as! ProjectsCell
        
        if indexPath.section == 0 {
            cell.cellSection = 1
        } else {
            cell.cellSection = 2
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (section%2 == 0) ? "My Projects":"Categories"
    }
    
}


