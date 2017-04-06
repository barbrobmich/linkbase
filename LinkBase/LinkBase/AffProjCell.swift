//
//  AffProjCell.swift
//  LinkBase
//
//  Created by Barbara Ristau on 4/5/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit

class AffProjCell: UITableViewCell {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var cellSection: Int!
    var currentUser: User!
    var projects: [Project] = []
    var affiliations: [Affiliation] = []
    var affProjMatch: [Any] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        currentUser = User.current()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        collectionView.delegate = self
        collectionView.dataSource = self
    }

}


extension AffProjCell: UICollectionViewDelegate, UICollectionViewDataSource {
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        if let cellSection = cellSection {
            
            switch cellSection {
            case 1:
                return 1
            case 2:
                return 2
            case 3:
                return 3
            default:
                break
            }
        }

        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AffProjCollectionCell", for: indexPath) as! AffProjCollectionCell
        
//        if cellSection == 1 {
//          //  cell.affProjNameLabel.text = mymatches[indexPath.item].name
//        }
//        else if cellSection == 2 {
//            cell.affProjNameLabel.text = projects[indexPath.item].name
//        }
//        else if cellSection == 3 {
//            cell.affProjNameLabel.text = affiliations[indexPath.item].name
//        }
//        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if cellSection == 1 {
            
         //   let selectedIndex = (affProjMatch[indexPath.item] as AnyObject).name!
         //   print("Selected Index: \(selectedIndex)")
            
        } else if cellSection == 2 {
            let selectedIndex = projects[indexPath.item].name!
            print("Selected Index: \(selectedIndex)")
        }  else if cellSection == 3 {
            let selectedIndex = affiliations[indexPath.item].name!
            print("Selected Index: \(selectedIndex)")
        }
    }
}
