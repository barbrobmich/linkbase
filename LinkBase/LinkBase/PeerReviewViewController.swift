//
//  PeerReviewViewController.swift
//  LinkBase
//
//  Created by Barbara Ristau on 3/27/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit
import AVFoundation

class PeerReviewViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var playRecordingButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    
    @IBOutlet weak var overallGradeLabel: UILabel!
    @IBOutlet weak var styleGradeLabel: UILabel!
    @IBOutlet weak var relevanceGradeLabel: UILabel!

    @IBOutlet weak var overallGradeSlider: UISlider!
    @IBOutlet weak var styleGradeSlider: UISlider!
    @IBOutlet weak var relevanceGradeSlider: UISlider!

    var challengeGame: ScoreCard! // need this to get current user, may change to PFUser
    var gradingCase: ScoreCard!
    var audioPlayer: AVAudioPlayer?
    var soundAsset: NSDataAsset!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        challengeGame = appDelegate.challengeGame
        
        questionLabel.text = gradingCase.commsQuestionsAnswered[0].question
    }

    // MARK: - AV Player Methods
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
     
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("Audio Play Decode Error")
    }
    
    

    // MARK: - IB Actions 
    
    @IBAction func tappedOnPlay(_ sender: UIButton) {
        print("Tapped on Play")
        
        do {
            print("playing the recording")
            
            audioPlayer = try AVAudioPlayer(data: soundAsset.data, fileTypeHint:"caf")
            audioPlayer!.delegate = self
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
        } catch let error as NSError {
            print("AudioPlayer error: \(error.localizedDescription)")
        }
    }
    
    @IBAction func tappedOnStopButton(_ sender: UIButton) {
        print("Pressed on Stop")
        audioPlayer?.stop()
    }
   
    
    @IBAction func tappedOnSubmit(_ sender: UIButton) {
        print("Tapped on Submit")
  
        gradingCase.commsQuestionsAnswered[0].points.overall = Int(overallGradeSlider.value)
        gradingCase.commsQuestionsAnswered[0].points.style = Int(styleGradeSlider.value)
        gradingCase.commsQuestionsAnswered[0].points.relevance = Int(relevanceGradeSlider.value)
        gradingCase.grader = challengeGame.player
        let currentDate = Date()
        gradingCase.dateGraded = currentDate
        
        print("Grader: \(gradingCase.grader!), Date Graded: \(gradingCase.dateGraded!), Points: overall \(gradingCase.commsQuestionsAnswered[0].points.overall), style: \(gradingCase.commsQuestionsAnswered[0].points.style), relevance: \(gradingCase.commsQuestionsAnswered[0].points.relevance)")
        
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
