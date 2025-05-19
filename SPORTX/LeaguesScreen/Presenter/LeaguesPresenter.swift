//
//  LeaguesPresenter.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 19/05/2025.
//

class LeaguesPresenter {
    var sportsType: APIConstants.Sport
    var view: LeaguesViewProtocol?
    private var SportsRepo: any SportsRepoProtocol

    init(sportsType: APIConstants.Sport) {
        self.sportsType = sportsType
        SportsRepo = SportRepoFactory.makeRepo(for: sportsType)
    }

    func getData() {
        SportsRepo.getLeagues { [weak self] result in
            guard let result = result, let self = self else { return }
            let newResult = result.compactMap{
                LeagueMapper.MapToLeague(forSport: self.sportsType, league: $0)
            }
            view?.updateData(leagues: newResult)
        }
    }
}
