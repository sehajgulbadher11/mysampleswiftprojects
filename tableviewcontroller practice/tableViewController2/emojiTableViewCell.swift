//
//  emojiTableViewCell.swift
//  tableViewController2
//
//  Created by Student on 22/08/25.
//

import UIKit

class emojiTableViewCell: UITableViewCell {

    @IBOutlet weak var symbol: UILabel!
   
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var des: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func updateUI(emoji:Emoji){
        symbol.text=emoji.symbol
        des.text=emoji.description
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
