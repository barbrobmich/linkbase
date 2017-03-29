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
    
    @IBOutlet weak var metric1Label: UILabel!
    @IBOutlet weak var metric2Label: UILabel!
    @IBOutlet weak var metric3Label: UILabel!
    @IBOutlet weak var metric4Label: UILabel!
    @IBOutlet weak var metric5Label: UISlider!
    
    
    @IBOutlet weak var metric1Slider: UISlider!
    @IBOutlet weak var metric2Slider: UISlider!
    @IBOutlet weak var metric3Slider: UISlider!
    @IBOutlet weak var metric4Slider: UISlider!
    @IBOutlet weak var metric5Slider: UISlider!
    
    var audioPlayer: AVAudioPlayer?
    var audioFileName: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }


    // MARK: - IB Actions 
    
    @IBAction func tappedOnPlay(_ sender: UIButton) {
        print("Tapped on Play")
        
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
    
    @IBAction func tappedOnSubmit(_ sender: UIButton) {
        print("Tapped on Submit")
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
