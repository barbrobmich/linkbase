//
//  AffiliationsCell.swift
//  LinkBase
//
//  Created by Barbara Ristau on 4/2/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit
import Parse


class AffiliationsCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!

    let categories = [Affiliation.category.Education, Affiliation.category.Professional, Affiliation.category.Community, Affiliation.category.Other]
    
    var cellSection: Int!
    var currentUser: User!
    var affiliations: [Affiliation] = []
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        currentUser = User.current()
        fetchAffiliations()
  
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    func fetchAffiliations() {
        
        let query = PFQuery(className: Affiliation.parseClassName())
        
        query.order(byDescending: "_created_at")
        //  query.includeKey("author")
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

    
}

extension AffiliationsCell: UICollectionViewDelegate, UICollectionViewDataSource {
   
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if cellSection == 1 {
            return affiliations.count
        }

        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! AffiliationCollectionCell
        
        if cellSection == 1 {
            cell.collectionTitleLabel.text = affiliations[indexPath.item].name
        }
        
        else if cellSection == 2 {
            cell.collectionTitleLabel.text = String(describing: categories[indexPath.item])
        }
        

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        if cellSection == 1 {
            
            let selectedIndex = affiliations[indexPath.item].name!
             print("Selected Index: \(selectedIndex)")
            
        } else if cellSection == 2 {
            let selectedIndex = categories[indexPath.item]
            print("Selected Index: \(selectedIndex)")
            
            
        }
   
    }
    
    
}
