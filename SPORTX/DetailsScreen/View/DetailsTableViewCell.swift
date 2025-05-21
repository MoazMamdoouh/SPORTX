//
//  DetailsTableViewCell.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 21/05/2025.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    @IBOutlet private weak var imgView: UIImageView!
    
    @IBOutlet private weak var playerName: UILabel!
    
    @IBOutlet private weak var playerNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(imgStringUrl: String, playerName: String, playerNumber: String) {
        let url = URL(string: imgStringUrl)
        imgView.kf.setImage(with: url, placeholder: UIImage(named: "sportx_logo"))
        
        self.playerName.text = playerName
        self.playerNumber.text = playerNumber
    }

}
