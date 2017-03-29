//
//  PeerReviewAllViewController.swift
//  LinkBase
//
//  Created by Barbara Ristau on 3/27/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit

class PeerReviewAllViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var testCases: [ScoreCard] = []
    var testCase1: ScoreCard!
    var t1AudioFile: URL!
    var testCase2: ScoreCard!
    var t2AudioFile: URL!
    
    var questions: CommsQuestionList!

    
    @IBOutlet weak var countLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questions = CommsQuestionList()
        
        // set up test cases
        
        testCase1 = ScoreCard(playerName: "Bart")
        testCase1.commsQuestionsAnswered.insert(questions.commList[0], at: 0)
        
        // set up date - test case is based on dates about 1 week from current date
        let currentDate = Date()
        let tc1Date = currentDate - 500000
        let tc2Date = currentDate - 750000
        
        // Not adding sound files at this stage, we will need to do so with real test data
        
        // add test case data to the objects
        testCase1.commsQuestionsAnswered[0].date = tc1Date
        testCase1.commsQuestionsAnswered[0].points.submit = 2
        print("Test Case 1: \(testCase1.player!) date: \(testCase1.commsQuestionsAnswered[0].date!)")
        
        testCase2 = ScoreCard(playerName: "Homer")
        testCase2.commsQuestionsAnswered.insert(questions.commList[2], at: 0)
        testCase2.commsQuestionsAnswered[0].date = tc2Date
        testCase2.commsQuestionsAnswered[0].points.submit = 2
        print("Test Case 2: \(testCase2.player!) date: \(testCase2.commsQuestionsAnswered[0].date!)")
        
        testCases.append(testCase1)
        testCases.append(testCase2)
        
        countLabel.text = String(describing: testCases.count)
        
        tableView.delegate = self
        tableView.dataSource = self 
    }

 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return testCases.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PeerCell", for: indexPath) as! PeerCell

        let item = testCases[indexPath.row]
        cell.testCase = item 
        cell.questionLabel.text = String(describing: item.commsQuestionsAnswered[0].question)
        cell.dateLabel.text = String(describing: item.commsQuestionsAnswered[0].date!)
        cell.userNameLabel.text = String(describing: item.player!)
        
        if cell.userNameLabel.text == "Bart"{
            cell.soundAsset = NSDataAsset(name: "bartFrench")
        } else {
            cell.soundAsset = NSDataAsset(name: "homerForgets")
        }
    
        return cell
    }
    

    // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        let cell = sender as! PeerCell
        let sendingTestCase = cell.testCase
        let peerReviewVC = segue.destination as! PeerReviewViewController
        peerReviewVC.gradingCase = sendingTestCase
        peerReviewVC.soundAsset = cell.soundAsset
        
    }

}
