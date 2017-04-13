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
    var selectedLanguage: String?
    var selectedAffiliationsDelegate: MatchedAffiliationsAndProjects?
    var selectedProjectsDelegate: MatchedAffiliationsAndProjects?
    var matchedItemsCount: Int!
    var combinedMatches: [Any] = []
    var retrievedAffiliations: [Affiliation] = []
    var retrievedProjects: [Project] = []
    var projectIndex: Int = 0
    
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
    
    // MARK: - FETCH PROJECTS, AFFILIATIONS & MATCHES
    
    func fetchAffiliations() {
        
        let query = PFQuery(className: Affiliation.parseClassName())
        
        query.order(byDescending: "_created_at")
        query.whereKey("user", equalTo: currentUser.username!)
        query.limit = 20
        query.findObjectsInBackground { (parseAffiliations: [PFObject]?, error: Error?) -> Void in
            
            if let myAffiliations = parseAffiliations {
                print("ParseAffiliations: \(parseAffiliations!)")
                for affiliation in myAffiliations {
                    if let affiliation = affiliation as? Affiliation {
                        // casting object as affiliation
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
                    if let project = project as? Project {
                        // casting object as project  
                        self.projects.append(project)
                    }
                }
                self.collectionView.reloadData()
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }
}

protocol MatchedAffiliationsAndProjects : class {
     func didSelectAffiliation(affiliation: Affiliation) -> Affiliation
     func didSelectProject(project: Project) -> Project
}



// MARK: - COLLECTIONVIEW EXTENSION

extension AffProjCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        if let cellSection = cellSection {
            
            switch cellSection {
            case 1:
                print("matchedItemsCount: \(matchedItemsCount!)")
                return matchedItemsCount
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
            
            if retrievedAffiliations.count != 0 && retrievedProjects.count == 0 {
                print("loading affiliations")
                cell.affiliation = retrievedAffiliations[indexPath.item]
                cell.affProjNameLabel.text = retrievedAffiliations[indexPath.item].name
            }
            else if retrievedProjects.count != 0 && retrievedAffiliations.count == 0 {
                print("loading projects")
                cell.project = retrievedProjects[indexPath.item]
                cell.affProjNameLabel.text = retrievedProjects[indexPath.item].name
            }
            else if retrievedAffiliations.count > 0 && retrievedProjects.count > 0 {
                print("loading affiliations & projects")
                if indexPath.item < retrievedAffiliations.count {
                    print("loading the affiliations first")
                    cell.affiliation = retrievedAffiliations[indexPath.item]
                    cell.affProjNameLabel.text = retrievedAffiliations[indexPath.item].name
                }
                 if indexPath.item >= retrievedAffiliations.count && indexPath.item < matchedItemsCount {
                    print("loading the projects second")
                    cell.project = retrievedProjects[projectIndex]
                    cell.affProjNameLabel.text = retrievedProjects[projectIndex].name
                    projectIndex += 1
                }
            }
            
        }
        else if cellSection == 2 {
            cell.affiliation = affiliations[indexPath.item]
            cell.affProjNameLabel.text = affiliations[indexPath.item].name
        }
        else if cellSection == 3 {
            cell.project = projects[indexPath.item]
            cell.affProjNameLabel.text = projects[indexPath.item].name
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if cellSection == 2 {
            let cell = collectionView.cellForItem(at: indexPath) as! AffProjCollectionCell
            let affiliation = cell.affiliation
            self.selectedAffiliationsDelegate?.didSelectAffiliation(affiliation: affiliation!)
            
            // add border if selected
            let affImageView = cell.affProjImageView
            affImageView?.layer.borderWidth = 5
            affImageView?.layer.borderColor = UIColor.red.cgColor
        }
        if cellSection == 3 {
            let cell = collectionView.cellForItem(at: indexPath) as! AffProjCollectionCell
            let project = cell.project
            self.selectedProjectsDelegate?.didSelectProject(project: project!)
            
            // add border if selected
            let projImageView = cell.affProjImageView
            projImageView?.layer.borderWidth = 5
            projImageView?.layer.borderColor = UIColor.red.cgColor
        }

    }
}
