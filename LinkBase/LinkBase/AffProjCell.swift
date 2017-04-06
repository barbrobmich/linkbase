//
//  AffProjCell.swift
//  LinkBase
//
//  Created by Barbara Ristau on 4/5/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class AffProjCell: UITableViewCell {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var cellSection: Int!
    var currentUser: User!
    var projects: [Project] = []
    var affiliations: [Affiliation] = []
    var matchedItems: [[Any]] = []
    var affProjMatch: [Any] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        currentUser = User.current()
        fetchAffiliations()
        fetchProjects()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - FETCH USER PROJECTS & AFFILIATIONS
    
    func fetchAffiliations() {
        
        let query = PFQuery(className: Affiliation.parseClassName())
        
        query.order(byDescending: "_created_at")
        query.whereKey("user", equalTo: currentUser.username!)
        query.limit = 20
        query.findObjectsInBackground { (parseAffiliations: [PFObject]?, error: Error?) -> Void in
            
            if let myAffiliations = parseAffiliations {
                print("ParseAffiliations: \(parseAffiliations!)")
                for affiliation in myAffiliations {
                    if affiliation is Affiliation {
                        print("object is subclass")
                    }
                    if let affiliation = affiliation as? Affiliation {
                        print("object cast as affiliation")
                        self.affiliations.append(affiliation)
                    }
                }
                self.collectionView.reloadData()
                
                print("First one is \(self.affiliations[0].name!)")
            } else {
                print(error?.localizedDescription as Any)
            }
        }
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


// MARK: - COLLECTIONVIEW EXTENSION

extension AffProjCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        if let cellSection = cellSection {
            
            switch cellSection {
            case 1:
                return matchedItems.count
            case 2:
                return affiliations.count
            case 3:
                return projects.count
            default:
                break
            }
        }

        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AffProjCollectionCell", for: indexPath) as! AffProjCollectionCell
        
        if cellSection == 1 {
          //  cell.affProjNameLabel.text = mymatches[indexPath.item].name
        }
        else if cellSection == 2 {
            cell.affProjNameLabel.text = affiliations[indexPath.item].name
        }
        else if cellSection == 3 {
            cell.affProjNameLabel.text = projects[indexPath.item].name
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if cellSection == 2 {
            let cell = collectionView.cellForItem(at: indexPath) as! AffProjCollectionCell
            let name = cell.affProjNameLabel.text
            print("AffiliationName: \(name!)")
            let affImageView = cell.affProjImageView
            affImageView?.layer.borderWidth = 5
            affImageView?.layer.borderColor = UIColor.red.cgColor
        }
        if cellSection == 3 {
            let cell = collectionView.cellForItem(at: indexPath) as! AffProjCollectionCell
            let name = cell.affProjNameLabel.text
            print("ProjectName: \(name!)")
            let projImageView = cell.affProjImageView
            projImageView?.layer.borderWidth = 5
            projImageView?.layer.borderColor = UIColor.red.cgColor
        }

    }
}
