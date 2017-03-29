//
//  FavoritesCompanyViewController.swift
//  LinkBase
//
//  Created by Rob Hernandez on 3/29/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit

class FavoritesCompanyViewController: UIViewController {
    @IBOutlet weak var favoriteCollection: UICollectionView!
    var companys: [Company] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteCollection.delegate = self
        favoriteCollection.dataSource = self
        let tempCompany = [ Company(id: 2, name: "Coupa", numEmployees: 500) ]
        self.companys = tempCompany
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - CollectionViewDelegate and Datasource
extension FavoritesCompanyViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.companys.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favoriteCollection.dequeueReusableCell(withReuseIdentifier: "favCompanyCell", for: indexPath) as! FavoriteCompanyCollectionCell
        let company = self.companys[indexPath.row]
        cell.company = company
        return cell
    }
}
