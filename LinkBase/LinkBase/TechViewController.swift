//
//  TechViewController.swift
//  LinkBase
//
//  Created by Barbara Ristau on 3/27/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit

class TechViewController: UIViewController {
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var ans1Button: UIButton!
    @IBOutlet weak var ans2Button: UIButton!
    @IBOutlet weak var ans3Button: UIButton!
    @IBOutlet weak var ans4Button: UIButton!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var progressIndicator: UIProgressView!
    
    var questions: TechQuestionList!
    var isCorrect: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        questions = TechQuestionList()
        questionLabel.text = questions.techList[0].question
        ans1Button.setTitle(questions.techList[0].ans1, for: .normal)
        ans2Button.setTitle(questions.techList[0].ans2, for: .normal)
        ans3Button.setTitle(questions.techList[0].ans3, for: .normal)
        ans4Button.setTitle(questions.techList[0].ans4, for: .normal)
    }

    
    func checkResults() {
        print("Checking results")
        isCorrect = true
        progressIndicator.setProgress(0.6, animated: true)
    
    }
    
    
    //MARK: - IB ACTIONS
    
    @IBAction func selectedAns1(_ sender: UIButton) {
        print("Selected Answer 1")
        ans1Button.tintColor = UIColor.red
    }
    
    
    @IBAction func selectedAns2(_ sender: UIButton) {
        print("Selected Answer 2")
        ans2Button.tintColor = UIColor.red

    }
    
    
    @IBAction func selectedAns3(_ sender: UIButton) {
        print("Selected Answer 3")
        ans3Button.tintColor = UIColor.red

    }
    
    @IBAction func selectedAns4(_ sender: UIButton) {
        print("Selected Answer 4")
        ans4Button.tintColor = UIColor.red

    }
    
  
    @IBAction func onSubmit(_ sender: UIButton) {
        print("Tapped on submit")
        checkResults()
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
