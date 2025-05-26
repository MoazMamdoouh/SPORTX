//
//  FavoriteTableViewController.swift
//  SPORTX
//
//  Created by moaz mamdouh on 21/05/2025.
//

import UIKit

private let reuseIdentifier = "LeaguesTableViewCell"
private let emptyReuseIdentifier = "EmptyCollectionViewCell"

class FavoriteTableViewController: UITableViewController {

    var favoritesLeagues : [FavoritesModel] = []
    var favoritePresenter : FavoritePresenter?
    var isNetworkConnecter : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        self.favoritePresenter = FavoritePresenter(coreDataRepo: CoreDataRepoImpl.shared)
        
        self.favoritesLeagues = favoritePresenter?.getAllLeagues() ?? []
        
        ReachabilityManager.simulateOffline(false)
        isNetworkConnecter = ReachabilityManager.isReachable()
        print("in the viewLoaded \(String(describing: isNetworkConnecter))")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoritesLeagues = favoritePresenter?.getAllLeagues() ?? []
        tableView.reloadData()
    }
    
    
    func setupView() {
        navigationItem.title = NSLocalizedString("favorite", comment: "favorite")
        let nib = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: emptyReuseIdentifier)

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return favoritesLeagues.isEmpty ? 1 : favoritesLeagues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        func makeEmptyCell(with message: String, for indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: emptyReuseIdentifier, for: indexPath)
            cell.contentView.subviews.forEach { $0.removeFromSuperview() }

            let label = UILabel()
            label.text = message
            label.font = .systemFont(ofSize: 19, weight: .bold)
            label.textColor = .systemGray
            label.textAlignment = .center
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            cell.contentView.addSubview(label)
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                label.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 8),
                label.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -8)
            ])
            return cell
        }
        
        guard !favoritesLeagues.isEmpty else {
            return makeEmptyCell(with: NSLocalizedString("no favorite leagues", comment: ""), for: indexPath)
        }

        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? LeaguesTableViewCell else {
            return UITableViewCell()
        }

        let currentLeague = favoritesLeagues[indexPath.row]
        cell.setData(imgStringURL: currentLeague.leagueImage ?? "", text: currentLeague.leagueName ?? "")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = self.view.bounds.height
        return height / 8
    }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let league = favoritesLeagues[indexPath.row]
            self.deleteLeagueDialogConfermation(leagueId: league.leagueId, indexPath: indexPath)
          }
    }
    
    private func deleteLeagueDialogConfermation(leagueId: Int32, indexPath: IndexPath){
        let alert = UIAlertController(
            title: NSLocalizedString("Delete League" , comment: "Title for delete league alert"),
            message: NSLocalizedString("delete league confirmation", comment: "Message for delete league alert"),
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("Cancel", comment: "Cancel button"),
            style: .cancel,
            handler: nil)
        )
        
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("Delete", comment: "Delete button"),
            style: .destructive,
            handler: { _ in
                self.favoritePresenter?.deleteLeague(leagueId: leagueId)
                self.favoritesLeagues.remove(at: indexPath.row)
                if self.favoritesLeagues.isEmpty {
                    self.tableView.reloadData()
                } else {
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                }
            })
        )
        
        present(alert, animated: true, completion: nil)
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if !ReachabilityManager.isReachable() {
            showNoInternetAlert()
            return
        }
        
        let storyboard = UIStoryboard(name: "Fixtures", bundle: nil)
        guard let fixturesVC = storyboard.instantiateViewController(withIdentifier: "Fixtures") as? FixturesCollectionViewController else { return }
        fixturesVC.presenter = favoritePresenter?.setupFixturePresenter(index: indexPath.row)
        navigationController?.pushViewController(fixturesVC, animated: true)
    }
     
    private func showNoInternetAlert() {
        let alert = UIAlertController(
            title: NSLocalizedString("no internet", comment: "No internet title"),
            message: NSLocalizedString("check internet", comment: "No internet message"),
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: "ok"), style: .default))
        present(alert, animated: true)
    }

    
}
