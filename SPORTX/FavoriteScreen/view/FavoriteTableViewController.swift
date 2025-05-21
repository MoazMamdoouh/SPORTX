//
//  FavoriteTableViewController.swift
//  SPORTX
//
//  Created by moaz mamdouh on 21/05/2025.
//

import UIKit

private let reuseIdentifier = "LeaguesTableViewCell"

class FavoriteTableViewController: UITableViewController {

    var favoritesModel : [FavoritesModel]?
    var favoritePresenter : FavoritePresenter?
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        self.favoritePresenter = FavoritePresenter(coreDataRepo: CoreDataRepoImpl.shared)
        
        self.favoritesModel = favoritePresenter?.getAllLeagues()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoritesModel = favoritePresenter?.getAllLeagues()
        tableView.reloadData()
    }
    
    
    func setupView() {
        navigationItem.title = NSLocalizedString("leagues", comment: "leagues")
        let nib = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return favoritesModel?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? LeaguesTableViewCell else {
            return UITableViewCell()
        }

        let currentLeague = favoritesModel?[indexPath.row]
        cell.setData(imgStringURL: currentLeague?.leagueImage ?? " ", text: currentLeague?.leagueName ?? " ")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = self.view.bounds.height
        return height / 8
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
              guard let league = favoritesModel?[indexPath.row] else { return }
            self.deleteLeagueDialogConfermation(leagueId: league.leagueId, indexPath: indexPath)
          }
    }
    
    private func deleteLeagueDialogConfermation(leagueId: Int32, indexPath: IndexPath){
        let alert = UIAlertController(
               title: "Delete League",
               message: "Are you sure you want to remove this league from favorites?",
               preferredStyle: .alert
           )
           
           alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
           
           alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
               // Perform deletion
               self.favoritePresenter?.deleteLeague(leagueId: leagueId)
               self.favoritesModel?.remove(at: indexPath.row)
               self.tableView.deleteRows(at: [indexPath], with: .fade)
           }))
           
           present(alert, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let storyboard = UIStoryboard(name: "Fixtures", bundle: nil)
        guard let fixturesVC = storyboard.instantiateViewController(withIdentifier: "Fixtures") as? FixturesCollectionViewController else { return }
        fixturesVC.presenter = favoritePresenter?.setupFixturePresenter(index: indexPath.row)
        navigationController?.pushViewController(fixturesVC, animated: true)
    }
        

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
