//
//  ResultsCell.swift
//  LinkBase
//
//  Created by Barbara Ristau on 3/27/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit

class ResultsCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // Outlets specific to Comms Questions
    
    @IBOutlet weak var pendingReviewLabel: UILabel!
    @IBOutlet weak var overallTextLabel: UILabel!
    @IBOutlet weak var overallScoreLabel: UILabel!
    @IBOutlet weak var styleTextLabel: UILabel!
    @IBOutlet weak var styleScoreLabel: UILabel!
    @IBOutlet weak var relevanceTextLabel: UILabel!
    @IBOutlet weak var relevanceScoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
