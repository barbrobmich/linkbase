//
//  AffProjCollectionCell.swift
//  LinkBase
//
//  Created by Barbara Ristau on 4/5/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit

class AffProjCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var affProjNameLabel: UILabel!
    @IBOutlet weak var affProjImageView: UIImageView!
    var affiliation: Affiliation!
    var project: Project! 
    
}
