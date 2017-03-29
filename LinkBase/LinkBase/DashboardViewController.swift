//
//  DashboardViewController.swift
//  LinkBase
//
//  Created by Barbara Ristau on 3/27/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    
    @IBOutlet weak var profileImageView: UIImageView! // need to connect this property to user
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var totalPointsLabel: UILabel!

    @IBOutlet weak var numProgrammingQuestionsLabel: UILabel!
    @IBOutlet weak var programmingAvgScoreLabel: UILabel!
    @IBOutlet weak var totalProgrammingScoreLabel: UILabel!

    
    @IBOutlet weak var numCommsQuestionsLabel: UILabel!
    @IBOutlet weak var commsAvgScoreLabel: UILabel!
    @IBOutlet weak var totalCommunicationScoreLabel: UILabel!
    
    @IBOutlet weak var programmingButton: UIButton!
    @IBOutlet weak var commsButton: UIButton!
    @IBOutlet weak var peerReviewButton: UIButton!
    
    var challengeGame: ScoreCard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        challengeGame = appDelegate.challengeGame
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadLabels()
    }
    
    func loadLabels() {
        
        userNameLabel.text = challengeGame.player
        
        numProgrammingQuestionsLabel.text = String(describing: challengeGame.techQuestionsAnswered.count)
        numCommsQuestionsLabel.text = String(describing: challengeGame.commsQuestionsAnswered.count)
        
        // get scores for each section
       
        // Programming Section
        var totalProgrammingScore: Int = 0
        
        for question in challengeGame.techQuestionsAnswered {
            let score = question.points
            totalProgrammingScore += score
        }
        
        if totalProgrammingScore == 0 {
            totalProgrammingScoreLabel.text = "N/A"
            programmingAvgScoreLabel.text = "N/A"
        } else {
            totalProgrammingScoreLabel.text = String(describing: totalProgrammingScore)
            let averageScore = totalProgrammingScore / challengeGame.techQuestionsAnswered.count
            programmingAvgScoreLabel.text = String(describing: averageScore)
        }
        
        // Communication Section 
        var totalCommunicationScore: Int = 0
        
        for question in challengeGame.commsQuestionsAnswered {
            let score = question.points.submit + question.points.overall + question.points.style + question.points.relevance
            totalCommunicationScore += score
        }
        
        if totalCommunicationScore == 0 {
            totalCommunicationScoreLabel.text = "N/A"
            commsAvgScoreLabel.text = "N/A"
        } else {
            totalCommunicationScoreLabel.text = String(describing: totalCommunicationScore)
            let avgScore = totalCommunicationScore / challengeGame.commsQuestionsAnswered.count
            commsAvgScoreLabel.text = String(describing: avgScore)
        }
        
        totalPointsLabel.text = String(describing: totalCommunicationScore + totalProgrammingScore)

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
            detailVC.resultsView = "Tech"
        }
        
        if segue.identifier == "CommunicationDetail" {
            print("Going to detail")
            let detailVC = segue.destination as! ResultsDetailViewController
            detailVC.navigationItem.title = "Communication Questions"
            detailVC.resultsView = "Comms"
        }
   }


}
