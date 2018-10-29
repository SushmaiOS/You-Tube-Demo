//
//  AllVidioesCell.swift
//  Youtube
//
//  Created by Mehboob on 10/4/18.
//  Copyright © 2018 360Nautica. All rights reserved.
//

import UIKit

class AllVidioesCell: UITableViewCell {

    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
