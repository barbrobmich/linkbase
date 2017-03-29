//
//  ResultsDetailViewController.swift
//  LinkBase
//
//  Created by Barbara Ristau on 3/27/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit

class ResultsDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!

    var challengeGame: ScoreCard!
    var resultsView: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        challengeGame = appDelegate.challengeGame
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count: Int = 0 
        
        if resultsView == "Tech" {
            count = challengeGame.techQuestionsAnswered.count
        } else if resultsView == "Comms" {
            count = challengeGame.commsQuestionsAnswered.count
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsCell", for: indexPath) as! ResultsCell
        
        if resultsView == "Tech" {
            if challengeGame.techQuestionsAnswered.count != 0{
                let question = challengeGame.techQuestionsAnswered[indexPath.row]
                cell.questionLabel.text = String(describing: question.question)
                cell.dateLabel.text = String(describing: question.date!)
                cell.scoreLabel.text = String(describing: question.points)
                
                cell.pendingReviewLabel.isHidden = true
                cell.overallTextLabel.isHidden = true
                cell.overallScoreLabel.isHidden = true
                cell.styleTextLabel.isHidden = true
                cell.styleScoreLabel.isHidden = true
                cell.relevanceTextLabel.isHidden = true
                cell.relevanceScoreLabel.isHidden = true
                
            } // else - display an alert stating that there are no questions
        }
        
        else if resultsView == "Comms" {
            if challengeGame.commsQuestionsAnswered.count != 0 {
                let question = challengeGame.commsQuestionsAnswered[indexPath.row]
                cell.questionLabel.text = String(describing: question.question)
                cell.dateLabel.text = String(describing: question.date!)
                cell.scoreLabel.text = String(describing: question.points.submit + question.points.overall + question.points.style + question.points.relevance)
                
                if question.points.overall == 0 {
                    cell.pendingReviewLabel.text = "Grades not yet available"
                    cell.overallTextLabel.isHidden = true
                    cell.overallScoreLabel.isHidden = true
                    cell.styleTextLabel.isHidden = true
                    cell.styleScoreLabel.isHidden = true
                    cell.relevanceTextLabel.isHidden = true
                    cell.relevanceScoreLabel.isHidden = true
                } else {
                    cell.overallScoreLabel.text = String(describing: question.points.overall)
                    cell.styleScoreLabel.text = String(describing: question.points.style)
                    cell.relevanceScoreLabel.text = String(describing: question.points.relevance)
                }
                
            } // else - display an alert stating that there are no questions
        }

        return cell

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
