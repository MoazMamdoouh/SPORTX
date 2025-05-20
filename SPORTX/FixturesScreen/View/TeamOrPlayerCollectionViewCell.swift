//
//  TeamOrPlayerCollectionViewCell.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 20/05/2025.
//

import UIKit

class TeamOrPlayerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var teamOrPlayerImageView: UIImageView!
    
    
    @IBOutlet private weak var teamOrPlayerName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        teamOrPlayerImageView.contentMode = .scaleAspectFit
//        teamOrPlayerImageView.layer.cornerRadius = teamOrPlayerImageView.bounds.width / 2
    }
    
    func setData(teamOrPlayerName: String, imageUrlString: String) {
        let imgURL = URL(string: imageUrlString)
        
        teamOrPlayerImageView.kf.setImage(with: imgURL, placeholder: UIImage(named: "sportx_logo"))
        self.teamOrPlayerName.text = teamOrPlayerName

    }

}
