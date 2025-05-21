//
//  FixtureCollectionReusableView.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 21/05/2025.
//

import UIKit

class SectionHeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with title: String) {
           titleLabel.text = title
       }
    
}
