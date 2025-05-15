//
//  SportsCollectionViewCell.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 14/05/2025.
//

import Kingfisher
import UIKit

class SportsCollectionViewCell: UICollectionViewCell {
    @IBOutlet var cellContainerView: UIView!
    @IBOutlet var cellLabel: UILabel!
    @IBOutlet var cellImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cellContainerView.clipsToBounds = true
        cellContainerView.layer.borderWidth = 1
        cellContainerView.layer.borderColor = UIColor.systemGray5.cgColor
        cellContainerView.layer.cornerRadius = 12
        cellContainerView.layer.masksToBounds = true
        cellImageView.contentMode = .scaleAspectFill
        cellImageView.clipsToBounds = true
        cellImageView.translatesAutoresizingMaskIntoConstraints = false



        // Initialization code
    }

    func setData(_ data: SportModel) {
        print(data.title)
        cellLabel.text = data.title
        print(data.imageName)
        cellImageView.image = UIImage(named: data.imageName)
    }
}
