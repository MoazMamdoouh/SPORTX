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
    
    @IBOutlet weak var teamOrPlayerImgView: UIImageView!
    
    @IBOutlet weak var teamOrPlayerName: UILabel!
    

    @IBOutlet var tableView: UITableView!
    @IBOutlet var coachOrCountryName: UILabel!
    @IBOutlet var coachOrCountryLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        guard let TeamOrPlayer = TeamOrPlayer, let sportType = sportType else { return }
        
        teamOrPlayerImgView.kf.setImage(with: URL(string: TeamOrPlayer.image), placeholder: UIImage(named: "sportx_logo"))
        
        teamOrPlayerName.text = TeamOrPlayer.name
        
        if sportType == .tennis {
            coachOrCountryLabel.text = "Country: "
        } else {
            coachOrCountryLabel.text = "Coach: "
        }
        
        coachOrCountryName.text = (TeamOrPlayer.coachOrCountry?.name) ?? ""
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TeamOrPlayer?.players?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell") as? DetailsTableViewCell else { return UITableViewCell() }
        if let player = TeamOrPlayer?.players?[indexPath.row] {
            cell.setData(imgStringUrl: player.image ?? "", playerName: player.name, playerNumber: player.number)
        }
        return cell
    }
}
