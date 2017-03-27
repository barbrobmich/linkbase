//
//  SetupViewController.swift
//  LinkBase
//
//  Created by Barbara Ristau on 3/27/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func onLoginTapped(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Login") as UIViewController
        
        self.present(controller, animated: true, completion: nil)
    }

    
    
    @IBAction func onCompanyTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Company", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Company") as UIViewController
        
        self.present(controller, animated: true, completion: nil)
    }
    
    
    @IBAction func onChallengeTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Challenge", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Challenge") as UIViewController
        
        self.present(controller, animated: true, completion: nil)
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
