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
    var correctAnswerCount: Int!
    var index: Int!
    var answer: Int!
    
    var challengeGame: ScoreCard!
    
    // add property for user points (gets incremented if 3 in a row are correct)
    
    // need to add response for getting 3 in a row correct
    
    override func viewDidLoad() {
        super.viewDidLoad()

        questions = TechQuestionList()
        correctAnswerCount = 0
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        challengeGame = appDelegate.challengeGame
        
        loadQuestion()
 
    }
    
    func loadQuestion() {
        
        index = getRandomNumber(count: questions.techList.count)
        
        questionLabel.text = questions.techList[index].question
        
        ans1Button.setTitle(questions.techList[index].answers[0], for: .normal)
        ans2Button.setTitle(questions.techList[index].answers[1], for: .normal)
        ans3Button.setTitle(questions.techList[index].answers[2], for: .normal)
        ans4Button.setTitle(questions.techList[index].answers[3], for: .normal)
        
    }

    
    func checkResults(answer: Int) {
        print("Checking results")
        
        // this part still needs further work.  Need to have a pause or some type of break between getting the response and presenting new question.
        
        // Need to have progress indicator increment / decrement based on whether or not 3 in a row have been answered 
        
        
        if (answer == questions.techList[index].correctAnswer){
            
            print("Correct!")
            isCorrect = true
            correctAnswerCount = correctAnswerCount + 1
            progressIndicator.setProgress(0.6, animated: true)
           
            updateScoreCard { (success) -> Void in
                if success{
                    let currentDate = Date()
                    challengeGame.techQuestionsAnswered[0].date = currentDate
                    print(challengeGame.techQuestionsAnswered[0].date!)
                }
            }
            
        } else {
            print("Sorry, try again")
            progressIndicator.setProgress(0.2, animated: true)
        }
        
        loadQuestion()
        
    }
    
    func updateScoreCard(completion: (_ success: Bool) -> Void) {
        
        challengeGame.techQuestionsAnswered.insert(questions.techList[index], at: 0)
    
        completion(true)
    }
    
    
    //MARK: - IB ACTIONS
    
    @IBAction func selectedAns1(_ sender: UIButton) {
        print("Selected Answer 1")
        answer = 0
        ans1Button.tintColor = UIColor.red
        ans2Button.tintColor = UIColor.black
        ans3Button.tintColor = UIColor.black
        ans4Button.tintColor = UIColor.black
    }
    
    
    @IBAction func selectedAns2(_ sender: UIButton) {
        print("Selected Answer 2")
        answer = 1
        ans2Button.tintColor = UIColor.red
        ans1Button.tintColor = UIColor.black
        ans3Button.tintColor = UIColor.black
        ans4Button.tintColor = UIColor.black

    }
    
    
    @IBAction func selectedAns3(_ sender: UIButton) {
        print("Selected Answer 3")
        answer = 2
        ans3Button.tintColor = UIColor.red
        ans1Button.tintColor = UIColor.black
        ans2Button.tintColor = UIColor.black
        ans4Button.tintColor = UIColor.black

    }
    
    @IBAction func selectedAns4(_ sender: UIButton) {
        print("Selected Answer 4")
        answer = 3
        ans4Button.tintColor = UIColor.red
        ans1Button.tintColor = UIColor.black
        ans2Button.tintColor = UIColor.black
        ans3Button.tintColor = UIColor.black

    }
    
  
    @IBAction func onSubmit(_ sender: UIButton) {
        print("Tapped on submit")
        checkResults(answer: answer)
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
