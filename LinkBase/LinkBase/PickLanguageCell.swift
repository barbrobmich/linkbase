//
//  PickLanguageCell.swift
//  LinkBase
//
//  Created by Barbara Ristau on 4/3/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit

class PickLanguageCell: UITableViewCell {
    
 
    @IBOutlet weak var collectionView: UICollectionView!
    
    let categories = [Language.category.Swift, Language.category.Java, Language.category.Javascript, Language.category.Python]
    
    var currentUser: User!
    
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

extension PickLanguageCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LanguageCollectionCell", for: indexPath) as! LanguageCollectionCell
        
         cell.languageLabel.text = String(describing: categories[indexPath.item])

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            let selectedIndex = categories[indexPath.item]
            print("Selected Index: \(selectedIndex)")
        
    }
    
  
    
}

