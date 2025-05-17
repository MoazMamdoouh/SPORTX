//
//  SportsCollectionViewController.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 15/05/2025.
//

import UIKit

private let reuseIdentifier = "SportsCollectionViewCell"

class SportsCollectionViewController: UICollectionViewController {
    let sportsArray = [
        SportModel(title: NSLocalizedString("football", comment: "football"), imageName: "football"),
        SportModel(title: NSLocalizedString("basketball", comment: "basketball"), imageName: "basketball"),
        SportModel(title: NSLocalizedString("cricket", comment: "cricket"), imageName: "cricket"),
        SportModel(title: NSLocalizedString("tennis", comment: "tennis"), imageName: "tennis"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        BasketballRepo(networkManager: NetworkManager.shared).getFixtures(leagueId: 11325) { result in
            guard let result = result else {
                return
            }
            print(result)
        }
    }

    func setupView() {
        navigationItem.title = NSLocalizedString("sports", comment: "sports")
        let nib = UINib(nibName: "SportsCollectionViewCell", bundle: nil)
        collectionView!.register(nib, forCellWithReuseIdentifier: reuseIdentifier)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),

        ])
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
        let screenWidth = self.collectionView.frame.width
        let availableWidth = screenWidth - 10
        let width = floor(availableWidth / itemsPerRow)

        let itemsPerColumn: CGFloat = 2
        let screenHeight = self.collectionView.frame.height
        let availableHeight = screenHeight - 20
        let height = floor(availableHeight / itemsPerColumn)

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
