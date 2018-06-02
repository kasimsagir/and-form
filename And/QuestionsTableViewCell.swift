//
//  QuestionsTableViewCell.swift
//  Albaraka Bizbize
//
//  Created by Ömer Çayırtepe on 19/08/16.
//  Copyright © 2016 albaraka. All rights reserved.
//

import UIKit

class QuestionsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblQuestionText: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
