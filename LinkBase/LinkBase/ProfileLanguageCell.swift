//
//  ProfileLanguageCell.swift
//  LinkBase
//
//  Created by Barbara Ristau on 4/7/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit

class ProfileLanguageCell: UITableViewCell {

    @IBOutlet weak var languageNameLabel: UILabel!
    @IBOutlet weak var languageImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var retrievedAffiliations: [Affiliation] = []
    var retrievedProjects: [Project] = [] 
    var matchedItemsCount: Int!
    var projectIndex: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        collectionView.dataSource = self
        collectionView.delegate = self
    }

}

extension ProfileLanguageCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return matchedItemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileLangCollectionCell", for: indexPath) as! ProfileLangCollectionCell
        
        cell.affProjNameLabel.text = "Item \(indexPath.item)"
   
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
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
    }

}
