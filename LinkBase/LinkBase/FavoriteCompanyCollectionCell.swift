//
//  FavoriteCompanyCollectionCell.swift
//  LinkBase
//
//  Created by Rob Hernandez on 3/29/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit

class FavoriteCompanyCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var numOfEmployee: UILabel!
    
    
    var company: Company!{
        didSet{
            companyName.text = company.name
            numOfEmployee.text = "\(company.numEmployees)"
        }
    }
}
