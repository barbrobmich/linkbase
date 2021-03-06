//
//  HomeCompanyViewController.swift
//  LinkBase
//
//  Created by Rob Hernandez on 3/29/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit

class HomeCompanyViewController: UIViewController {

    @IBOutlet weak var CompanyCollection: UICollectionView!
    var companys: [Company] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        CompanyCollection.delegate = self
        CompanyCollection.dataSource = self
        
        // Make temp Company data
        let tempCompany = [Company(id: 1, name: "Uber", numEmployees: 100),
                       Company(id: 2, name: "Coupa", numEmployees: 500),
                       Company(id: 3, name: "Google", numEmployees: 9001)]
        self.companys = tempCompany
        
    }
    @IBAction func editProfile(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ProfileSetup") as UIViewController
        
        self.present(controller, animated: true, completion: nil)
    }

    @IBAction func goChallenge(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Challenge", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ChallengeTabBarController") as! UITabBarController
        
        self.present(controller, animated: true, completion: nil)
    }

    
      //MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      //Get the new view controller using segue.destinationViewController.
      //Pass the selected object to the new view controller.
        if let sender = sender as? CompanyCollectionCell{
            let vc = segue.destination as! CompanyDetailViewController
            vc.company = sender.company
        }
     }
 

}

//MARK: - CollectionViewDelegate and Datasource
extension HomeCompanyViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // First section is hello blurb
        if section == 0{
            return 1
        // Second section is Company Data
        }else if section == 1{
            return self.companys.count
        }else{
            // Third section is optional(Trending)
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CompanyCollection.dequeueReusableCell(withReuseIdentifier: "companyCell", for: indexPath) as! CompanyCollectionCell
        let company = self.companys[indexPath.row]
        cell.company = company
        return cell
    }
    
    
}
