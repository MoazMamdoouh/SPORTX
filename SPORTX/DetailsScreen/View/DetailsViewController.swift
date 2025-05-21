//
//  DetailsViewController.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 21/05/2025.
//

import UIKit
import Kingfisher
class DetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var TeamOrPlayer: TeamOrPlayer?
    var sportType: APIConstants.Sport?
    
    @IBOutlet private weak var teamOrPlayerImgView: UIImageView!
    
    @IBOutlet private weak var teamOrPlayerName: UILabel!
    

    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var coachOrCountryName: UILabel!
    @IBOutlet private var coachOrCountryLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        guard let TeamOrPlayer = TeamOrPlayer, let sportType = sportType else { return }
        
        teamOrPlayerImgView.kf.setImage(with: URL(string: TeamOrPlayer.image), placeholder: UIImage(named: "sportx_logo"))
        
        teamOrPlayerName.text = TeamOrPlayer.name
        
        if sportType == .tennis {
            navigationItem.title = NSLocalizedString("player details", comment: "player details")

            coachOrCountryLabel.text = NSLocalizedString("country", comment: "country")
        } else {
            navigationItem.title = NSLocalizedString("team details", comment: "player details")
            coachOrCountryLabel.text = NSLocalizedString("coach", comment: "coach")

        }
        
        coachOrCountryName.text = (TeamOrPlayer.coachOrCountry?.name) ?? ""
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(TeamOrPlayer?.players?.count)
        return TeamOrPlayer?.players?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell") as? DetailsTableViewCell else { return UITableViewCell() }
        if let player = TeamOrPlayer?.players?[indexPath.row] {
            cell.setData(imgStringUrl: player.image ?? "", playerName: player.name, playerNumber: player.number)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
