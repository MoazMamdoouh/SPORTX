//
//  SportsCollectionViewCell.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 14/05/2025.
//

import Kingfisher
import UIKit

class SportsCollectionViewCell: UICollectionViewCell {
    @IBOutlet var cellLabel: UILabel!
    @IBOutlet var cellImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cellImageView.contentMode = .scaleAspectFill
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 12

    }

    func setData(_ data: SportModel) {
        cellLabel.text = data.title
        cellImageView.image = UIImage(named: data.imageName)
    }
}
