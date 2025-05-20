//
//  FixturesCollectionViewController.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 20/05/2025.
//

import UIKit

private let fixtureReuseIdentifier = "FixtureCollectionViewCell"
private let teamOrPlayerReuseIdentifier = "TeamOrPlayerCollectionViewCell"
private let sectionHeaderReuseIdentifier = "SectionHeaderView"

class FixturesCollectionViewController: UICollectionViewController, FixtureViewProtocol {
    var upcomingMatchesArray = [Fixture]()
    var latestMatchesArray = [Fixture]()
    var TeamsOrPlayersArray = [TeamOrPlayer]()

    var presenter: FixturesPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        guard let presenter else { return }
        presenter.view = self
        presenter.getData()
    }

    func setupView() {
        navigationItem.title = NSLocalizedString("fixtures", comment: "fixtures")
        let fixtureCellNib = UINib(nibName: "FixtureCollectionViewCell", bundle: nil)
        let teamOrPlayerCellNib = UINib(nibName: "TeamOrPlayerCollectionViewCell", bundle: nil)
        let headerNib = UINib(nibName: "SectionHeaderView", bundle: nil)

        collectionView.register(fixtureCellNib, forCellWithReuseIdentifier: fixtureReuseIdentifier)
        collectionView.register(teamOrPlayerCellNib, forCellWithReuseIdentifier: teamOrPlayerReuseIdentifier)

        collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderReuseIdentifier)

        let layout = UICollectionViewCompositionalLayout { [weak self] index, _ in
            switch index {
            case 0:
                return self?.drawHorizontalUpcomingMatchesSection()
            case 1:
                return self?.drawVerticalLatestMatchesSection()
            default:
                return self?.drawTeamsOrPlayerSection()
            }
        }

        collectionView.setCollectionViewLayout(layout, animated: true)
    }

    func drawHorizontalUpcomingMatchesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85), heightDimension: .absolute(250))

        let myGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: myGroup)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 8, bottom: 8, trailing: 0)

//        section.visibleItemsInvalidationHandler = { items, offset, environment in
//            items.forEach { item in
//                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
//                let minScale: CGFloat = 0.8
//                let maxScale: CGFloat = 1.0
//                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
//                item.transform = CGAffineTransform(scaleX: scale, y: scale)
//            }
//        }

        return section
    }

    func drawVerticalLatestMatchesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(270))

        let myGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: myGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)

//        section.visibleItemsInvalidationHandler = { items, offset, environment in
//            items.forEach { item in
//                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
//                let minScale: CGFloat = 0.8
//                let maxScale: CGFloat = 1.0
//                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
//                item.transform = CGAffineTransform(scaleX: scale, y: scale)
//            }
//        }

        return section
    }

    func drawTeamsOrPlayerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .absolute(200))

        let myGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: myGroup)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 16, bottom: 16, trailing: 0)

//        section.visibleItemsInvalidationHandler = { items, offset, environment in
//            items.forEach { item in
//                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
//                let minScale: CGFloat = 0.8
//                let maxScale: CGFloat = 1.0
//                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
//                item.transform = CGAffineTransform(scaleX: scale, y: scale)
//            }
//        }

        return section
    }

    func updateData(teamOrPlayer: [TeamOrPlayer]) {
        TeamsOrPlayersArray = teamOrPlayer
        collectionView.reloadData()
    }

    func updateData(upcomingFixture: [Fixture], latestFixture: [Fixture]) {
        upcomingMatchesArray = upcomingFixture
        latestMatchesArray = latestFixture
        collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return upcomingMatchesArray.count
        case 1: return latestMatchesArray.count
        case 2: return TeamsOrPlayersArray.count
        default:
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: fixtureReuseIdentifier, for: indexPath) as? FixtureCollectionViewCell else { return UICollectionViewCell() }
            let currentData = upcomingMatchesArray[indexPath.row]

            cell.setData(homeTeamName: currentData.homeTeamName,
                         homeTeamImageURLString: currentData.homeTeamImage,
                         awayTeamName: currentData.awayTeamName,
                         awayTeamImageURLString: currentData.awayTeamImage,
                         date: currentData.date,
                         time: currentData.time,
                         finalResult: nil)
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: fixtureReuseIdentifier, for: indexPath) as? FixtureCollectionViewCell else { return UICollectionViewCell() }
            let currentData = latestMatchesArray[indexPath.row]

            cell.setData(homeTeamName: currentData.homeTeamName,
                         homeTeamImageURLString: currentData.homeTeamImage,
                         awayTeamName: currentData.awayTeamName,
                         awayTeamImageURLString: currentData.awayTeamImage,
                         date: currentData.date,
                         time: currentData.time,
                         finalResult: currentData.finalResult)
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: teamOrPlayerReuseIdentifier, for: indexPath) as? TeamOrPlayerCollectionViewCell else { return UICollectionViewCell() }
            let currentData = TeamsOrPlayersArray[indexPath.row]
            cell.setData(teamOrPlayerName: currentData.name, imageUrlString: currentData.image)
            return cell
        default:
            return UICollectionViewCell()
        }
    }

    // MARK: UICollectionViewDelegate

    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
         return true
     }
     */

    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
         return true
     }
     */

    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
         return false
     }

     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
         return false
     }

     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {

     }
     */
}
