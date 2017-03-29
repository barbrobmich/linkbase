//
//  CompanyDetailViewController.swift
//  LinkBase
//
//  Created by Rob Hernandez on 3/29/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit

class CompanyDetailViewController: UIViewController {
    var company: Company!

    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var numEmployees: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set data from Company
        companyName.text = company.name
        numEmployees.text = "\(company.numEmployees)"
    }





}
