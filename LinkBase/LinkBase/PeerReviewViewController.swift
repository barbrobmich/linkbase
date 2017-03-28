//
//  PeerReviewViewController.swift
//  LinkBase
//
//  Created by Barbara Ristau on 3/27/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit

class PeerReviewViewController: UIViewController {

    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }


    // MARK: - IB Actions 
    
    @IBAction func tappedOnPlay(_ sender: UIButton) {
        print("Tapped on Play")
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
