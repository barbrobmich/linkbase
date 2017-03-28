//
//  CommsViewController.swift
//  LinkBase
//
//  Created by Barbara Ristau on 3/27/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit
import AVFoundation

class CommsViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {

    
    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var newQuestionButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var submitResponseButton: UIButton!
    
    var recordingSession: AVAudioSession?
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    var audioFileName: URL?
    
    var questions: CommsQuestionList!
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // new question should appear - need to work on model
        questions = CommsQuestionList()
     
        loadQuestion()
        
        // set up recording session
        
        recordingSession = AVAudioSession.sharedInstance()
    
        do {
            try recordingSession?.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession?.setActive(true)
            recordingSession?.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                      //  self.loadRecordingUI()
                    } else {
                        // failed to record!
                    }
                }
            }
        } catch {
            // failed to record!
        }
    }
    
    func loadQuestion() {
        
        index = getRandomNumber(count: (questions.commList.count))
        questionTextLabel.text = questions.commList[index].question
        
    }
    
    
    
    // MARK: - AV RECORDING METHODS
    
    func startRecording() {
        
        audioFileName = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFileName!, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.record()
            
            recordButton.setTitle("Tap to Stop", for: .normal)
        } catch {
            finishRecording(success: false)
        }
        
        
    }
    
    func getDocumentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        print(paths[0])
        return documentsDirectory
    }
    
    func finishRecording(success: Bool) {
        audioRecorder?.stop()
        audioRecorder = nil
        
        if success {
            recordButton.setTitle("Tap to Re-record", for: .normal)
        } else {
            recordButton.setTitle("Tap to Record", for: .normal)
            // recording failed - message or action
        }
    }
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag{
            finishRecording(success: false)
            recordButton.isEnabled = true
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordButton.isEnabled = true
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("Audio Play Decode Error")
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        print("Audio Record Encode Error")
    }
    
    
    // MARK: - ACTION BUTTONS
    
    @IBAction func onNewQuestionTapped(_ sender: UIButton) {
        print("Tapped on button to request new question")
        loadQuestion()
        
    }
    
    
    @IBAction func onStartRecordingTapped(_ sender: UIButton) {
        print("Tapped on record button")
        
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
        
    }
    
    
    @IBAction func tappedOnPlay(_ sender: UIButton) {
        print("Tapped on play")
  
            do {
                print("playing the recording")
                
                try audioPlayer = AVAudioPlayer(contentsOf: (audioFileName)!)
                audioPlayer!.delegate = self
                audioPlayer!.prepareToPlay()
                audioPlayer!.play()
            } catch let error as NSError {
                print("AudioPlayer error: \(error.localizedDescription)")
            }

    }
    
    @IBAction func onSubmit(_ sender: UIButton) {
        print("Tapped on submit")
        
        // need to submit to Parse 
        
        let hudView = HudView.hud(inView: self.view, animated: true)
        hudView.text = "Done!"
        
        afterDelay(0.6) {
            hudView.isHidden = true
            hudView.removeFromSuperview()
        }
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
