//
//  LeaguesTableViewController.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 19/05/2025.
//

import UIKit

private let reuseIdentifier = "LeaguesTableViewCell"

class LeaguesTableViewController: UITableViewController, LeaguesViewProtocol {
    
    var leaguesArray = [League]()
    var presenter: LeaguesPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let presenter = presenter else { return }
        presenter.view = self
        presenter.getData()
        setupView()
    }

    func setupView() {
        navigationItem.title = NSLocalizedString("leagues", comment: "leagues")
        let nib = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? LeaguesTableViewCell else {
            return UITableViewCell()
        }

        let currentLeague = leaguesArray[indexPath.row]
        print("\(currentLeague.leagueName) \(currentLeague.leagueImage)")
        cell.setData(imgStringURL: currentLeague.leagueImage, text: currentLeague.leagueName)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = self.view.bounds.height
        return height / 8
    }

    func updateData(leagues: [League]) {
        leaguesArray = leagues
        tableView.reloadData()
    }

}

