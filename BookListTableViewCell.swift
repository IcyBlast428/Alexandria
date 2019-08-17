//
//  BookListTableViewCell.swift
//  Alexandria
//
//  Created by IcyBlast on 19/4/18.
//  Copyright © 2018 IcyBlast. All rights reserved.
//

import UIKit

class BookListTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
