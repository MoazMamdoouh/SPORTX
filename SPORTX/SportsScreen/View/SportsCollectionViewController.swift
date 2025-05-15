//
//  SportsCollectionViewController.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 15/05/2025.
//

import UIKit

private let reuseIdentifier = "SportsCollectionViewCell"

class SportsCollectionViewController: UICollectionViewController {
//    var sportsArray: [SportModel] = []
    let sportsArray = [
        SportModel(title: NSLocalizedString("football", comment: "football"), imageName: "football"),
        SportModel(title: NSLocalizedString("basketball", comment: "basketball"), imageName: "basketball"),
        SportModel(title: NSLocalizedString("cricket", comment: "cricket"), imageName: "cricket"),
        SportModel(title: NSLocalizedString("tennis", comment: "tennis"), imageName: "tennis"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = NSLocalizedString("sports", comment: "sports")
        let nib = UINib(nibName: "SportsCollectionViewCell", bundle: nil)
        collectionView!.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? SportsCollectionViewCell else {
            return UICollectionViewCell()
        }

        print(sportsArray[indexPath.row])
        cell.setData(sportsArray[indexPath.row])

        return cell
    }

    // MARK: UICollectionViewDelegate

//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//    }
}

extension SportsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 2
        let screenWidth = UIScreen.main.bounds.width
        let availableWidth = screenWidth - 40
        let width = floor(availableWidth / itemsPerRow)

        return CGSize(width: width, height: width * 1.2)
    }

//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 16
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 16
//    }

}
