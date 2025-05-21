//
//  FixturesCollectionViewController.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 20/05/2025.
//

import UIKit

private let fixtureReuseIdentifier = "FixtureCollectionViewCell"
private let teamOrPlayerReuseIdentifier = "TeamOrPlayerCollectionViewCell"
private let sectionHeaderReuseIdentifier = "SectionHeaderCollectionReusableView"

class FixturesCollectionViewController: UICollectionViewController, FixtureViewProtocol {
    var upcomingMatchesArray = [Fixture]()
    var latestMatchesArray = [Fixture]()
    var TeamsOrPlayersArray = [TeamOrPlayer]()
    var presenter: FixturesPresenter?

    var isFavorite: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        guard let presenter else { return }
        presenter.view = self
        presenter.getData()

        isFavorite = presenter.checkIfLeagueExistInCoreData()
        updateFavoriteButtonIcon()
    }

    override func viewWillAppear(_ animated: Bool) {
        isFavorite = presenter?.checkIfLeagueExistInCoreData()
        updateFavoriteButtonIcon()
    }

    func setupView() {
        let heartImage = UIImage(systemName: isFavorite ?? false ? "heart.fill" : "heart")
        let favoriteButton = UIBarButtonItem(image: heartImage, style: .plain, target: self, action: #selector(favoriteButtonTapped))
        navigationItem.rightBarButtonItem = favoriteButton

        navigationItem.title = NSLocalizedString("fixtures", comment: "fixtures")
        let fixtureCellNib = UINib(nibName: "FixtureCollectionViewCell", bundle: nil)
        let teamOrPlayerCellNib = UINib(nibName: "TeamOrPlayerCollectionViewCell", bundle: nil)
        let headerNib = UINib(nibName: "SectionHeaderCollectionReusableView", bundle: nil)

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

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(250))

        let myGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: myGroup)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 8, bottom: 8, trailing: 0)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [sectionHeader]

        section.visibleItemsInvalidationHandler = { items, offset, environment in
            items
                .filter { $0.representedElementCategory == .cell }
                .forEach { item in
                    let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                    let minScale: CGFloat = 0.8
                    let maxScale: CGFloat = 1.0
                    let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                    item.transform = CGAffineTransform(scaleX: scale, y: scale)
                }
        }

        return section
    }

    func drawVerticalLatestMatchesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250))

        let myGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: myGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 0)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [sectionHeader]

        section.visibleItemsInvalidationHandler = { items, offset, environment in
            let centerY = offset.y + environment.container.contentSize.height / 2
            let maxDistance = environment.container.contentSize.height / 2

            items
                .filter { $0.representedElementCategory == .cell }
                .forEach { item in
                    let distance = abs(item.frame.midY - centerY)
                    let minScale: CGFloat = 0.8
                    let maxScale: CGFloat = 1.0
                    let scale = max(maxScale - distance / maxDistance, minScale)
                    item.transform = CGAffineTransform(scaleX: scale, y: scale)
                }
        }

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

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [sectionHeader]

        section.visibleItemsInvalidationHandler = { items, offset, environment in
            items.filter { $0.representedElementCategory == .cell }
                .forEach { item in
                    let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                    let minScale: CGFloat = 0.8
                    let maxScale: CGFloat = 1.0
                    let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                    item.transform = CGAffineTransform(scaleX: scale, y: scale)
                }
        }

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

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            // print("stopped here")
            return UICollectionReusableView()
        }

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeaderReuseIdentifier, for: indexPath) as! SectionHeaderCollectionReusableView

        let title: String
        switch indexPath.section {
        case 0: title = NSLocalizedString("Upcoming Matches", comment: "")
        case 1: title = NSLocalizedString("Latest Matches", comment: "")
        case 2: title = NSLocalizedString("Teams or Players", comment: "")
        default: title = ""
        }

        header.configure(with: title)
        return header
    }

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

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let storyboard = UIStoryboard(name: "Details", bundle: nil)
            guard let detailsVC = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else { return }
                
            detailsVC.TeamOrPlayer = TeamsOrPlayersArray[indexPath.row]
            detailsVC.sportType = presenter?.sportsType
            navigationController?.pushViewController(detailsVC, animated: true)
            print(TeamsOrPlayersArray[indexPath.row].players)
        }
    }

    @objc func favoriteButtonTapped() {
        guard let presenter else { return }

        if isFavorite == true {
            deleteLeagueDialogConfermation()
        } else {
            presenter.saveLeagueToFavorite()
            isFavorite?.toggle()
            updateFavoriteButtonIcon()
            print("League added to favorites.")
        }
    }

    func updateFavoriteButtonIcon() {
        let heartImage = UIImage(systemName: isFavorite ?? false ? "heart.fill" : "heart")
        navigationItem.rightBarButtonItem?.image = heartImage
    }

    private func deleteLeagueDialogConfermation() {
        let alert = UIAlertController(
            title: "Delete League",
            message: "Are you sure you want to remove this league from favorites?",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.presenter?.deleteLeague()
            self.isFavorite?.toggle()
            self.updateFavoriteButtonIcon()
            print("League removed from favorites.")
        }))

        present(alert, animated: true, completion: nil)
    }
}
