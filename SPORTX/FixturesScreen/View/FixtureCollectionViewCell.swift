//
//  FixtureCollectionViewCell.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 20/05/2025.
//

import Kingfisher
import UIKit
class FixtureCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var borderView: UIView!

    @IBOutlet private var homeTeamImage: UIImageView!

    @IBOutlet private var homeTeamName: UILabel!

    @IBOutlet private var awayTeamImage: UIImageView!

    @IBOutlet private var awayTeamName: UILabel!

    @IBOutlet private var versusLabel: UILabel!

    @IBOutlet private var dateLabel: UILabel!

    @IBOutlet private var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        homeTeamImage.contentMode = .scaleAspectFit
        awayTeamImage.contentMode = .scaleAspectFit
//        homeTeamImage.layer.cornerRadius = homeTeamImage.bounds.width / 2
//        awayTeamImage.layer.cornerRadius = awayTeamImage.bounds.width / 2
//        homeTeamImage.clipsToBounds = true
//        awayTeamImage.clipsToBounds = true

        borderView.layer.borderWidth = 2
        borderView.layer.borderColor = UIColor(resource: .blackwhitecolor).cgColor
        borderView.layer.cornerRadius = 12

        versusLabel.text = NSLocalizedString("vs", comment: "vs")
    }

    func setData(homeTeamName: String, homeTeamImageURLString: String, awayTeamName: String, awayTeamImageURLString: String, date: String, time: String, finalResult: String? = nil) {
        let homeImgURL1 = URL(string: homeTeamImageURLString)
        let awayImgURL = URL(string: awayTeamImageURLString)

        homeTeamImage.kf.setImage(with: homeImgURL1, placeholder: UIImage(named: "sportx_logo"))
        awayTeamImage.kf.setImage(with: awayImgURL, placeholder: UIImage(named: "sportx_logo"))
        self.homeTeamName.text = homeTeamName
        self.awayTeamName.text = awayTeamName
        dateLabel.text = date
        timeLabel.text = time
        if let finalResult {
            versusLabel.text = finalResult
        }
        else {
            versusLabel.text = NSLocalizedString("vs", comment: "vs")
        }
    }
}
