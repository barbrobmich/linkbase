//
//  ProjectsCell.swift
//  LinkBase
//
//  Created by Barbara Ristau on 4/3/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProjectsCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let categories = [Project.category.GitHub, Project.category.Hackathon, Project.category.Community, Project.category.Other]
    var cellSection: Int!
    var currentUser: User!
    var projects: [Project] = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        currentUser = User.current()
        fetchProjects()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func fetchProjects() {
        
        let query = PFQuery(className: Project.parseClassName())
        
        query.order(byDescending: "_created_at")
        query.whereKey("user", equalTo: currentUser.username!)
        query.limit = 20
        query.findObjectsInBackground { (parseProjects: [PFObject]?, error: Error?) -> Void in
            
            if let myProjects = parseProjects {
                print("ParseProjects: \(myProjects)")
                for project in myProjects {
                    if project is Project {
                        print("object is subclass")
                    }
                    if let project = project as? Project {
                        print("object cast as project")
                        self.projects.append(project)
                    }
                }
                self.collectionView.reloadData()
                
            //    print("First one is \(self.projects[0].name!)")
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }
    


}

extension ProjectsCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if cellSection == 1 {
            return projects.count
        }
        
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCollectionCell", for: indexPath) as! ProjectCollectionCell
        
        if cellSection == 1 {
            cell.projectNameLabel.text = projects[indexPath.item].name
        }
            
        else if cellSection == 2 {
            cell.projectNameLabel.text = String(describing: categories[indexPath.item])
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if cellSection == 1 {
            
            let selectedIndex = projects[indexPath.item].name!
            print("Selected Index: \(selectedIndex)")
            
        } else if cellSection == 2 {
            let selectedIndex = categories[indexPath.item]
            print("Selected Index: \(selectedIndex)")

        }
        
    }
    
    
}

