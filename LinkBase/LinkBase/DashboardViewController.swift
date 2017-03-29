//
//  DashboardViewController.swift
//  LinkBase
//
//  Created by Barbara Ristau on 3/27/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var totalPointsLabel: UILabel!

    @IBOutlet weak var numProgrammingQuestionsLabel: UILabel!
    @IBOutlet weak var programmingAvgScoreLabel: UILabel!
    @IBOutlet weak var numCommsQuestionsLabel: UILabel!
    @IBOutlet weak var commsAvgScoreLabel: UILabel!
    
    
    @IBOutlet weak var programmingButton: UIButton!
    @IBOutlet weak var commsButton: UIButton!
    @IBOutlet weak var peerReviewButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    
    // MARK: - IB Actions 
    
    @IBAction func onProgrammingTapped(_ sender: UIButton) {
        print("Tapped on programming detail")
  
    }
    
    @IBAction func onCommsTapped(_ sender: UIButton) {
        print("Tapped on communication detail")
    }
    
    
    @IBAction func onPeerReviewTapped(_ sender: UIButton) {
        print("Tapped on peer review") 
    }

    // MARK: - Navigation

      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Preparing for segue")
      
     
        if segue.identifier == "ProgrammingDetail" {
            print("Going to detail")
            let detailVC = segue.destination as! ResultsDetailViewController
            detailVC.navigationItem.title = "Programming Questions"
        }
        
        if segue.identifier == "CommunicationDetail" {
            print("Going to detail")
            let detailVC = segue.destination as! ResultsDetailViewController
            detailVC.navigationItem.title = "Communication Questions"
        }
   }


}
