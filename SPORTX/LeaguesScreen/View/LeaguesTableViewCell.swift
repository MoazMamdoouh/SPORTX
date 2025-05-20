//
//  LeaguesTableViewCell.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 19/05/2025.
//

import UIKit
import Kingfisher

class LeaguesTableViewCell: UITableViewCell {
    @IBOutlet private weak var borderView: UIView!
    
    @IBOutlet private weak var imgView: UIImageView!
    
    @IBOutlet private weak var textLabelView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.contentMode = .scaleAspectFit
        imgView.layer.cornerRadius = imgView.bounds.width / 2
        imgView.clipsToBounds = true
        borderView.layer.borderWidth = 2
        borderView.layer.borderColor = UIColor(resource: .blackwhitecolor).cgColor
        borderView.layer.cornerRadius = 12
    }
    
    func setData(imgStringURL: String, text: String) {
        let imgURL = URL(string: imgStringURL)
        imgView.kf.setImage(with: imgURL, placeholder: UIImage(named: "sportx_logo"))
        textLabelView.text = text
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
