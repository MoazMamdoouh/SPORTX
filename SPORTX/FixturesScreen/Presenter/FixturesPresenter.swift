//
//  FixturesPresenter.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 20/05/2025.
//

class FixturesPresenter {
    var view: FixtureViewProtocol?
    var sportsType: APIConstants.Sport
    var SportsRepo: any SportRepoProtocol
    var league : League
    private var coredataRepo : CoreDataRepo?

    init(sportsType: APIConstants.Sport, SportsRepo: any SportRepoProtocol, league : League ) {
        self.sportsType = sportsType
        self.SportsRepo = SportsRepo
        self.league = league
    }

    func getData() {
        getFixtures()
        getTeamsOrPlayers()
    }

    private func getFixtures() {
        SportsRepo.getFixtures(leagueId: league.leagueKey) { [weak self] result in
            guard let result = result, let self = self else { return }
            let newResult = result.compactMap {
                FixtureMapper.MapToFixture(forSport: self.sportsType, fixture: $0)
            }
            var upcomingFixture: [Fixture] = []
            var latestFixture: [Fixture] = []
            newResult.forEach { fixture in
                if(fixture.finalResult == nil || fixture.finalResult == "" || fixture.finalResult == "-"){
                    upcomingFixture.append(fixture)
                } else {
                    latestFixture.append(fixture)
                }
            }
            view?.updateData(upcomingFixture: upcomingFixture, latestFixture: latestFixture)
        }
    }

    private func getTeamsOrPlayers() {
        SportsRepo.getTeamsOrPlayers(leagueId: league.leagueKey) { [weak self] result in
            guard let result = result, let self = self else { return }
            let newResult = result.compactMap {
                TeamOrPlayerMapper.MapToTeamOrPlayer(forSport: self.sportsType, teamOrPlayer: $0)
            }
            view?.updateData(teamOrPlayer: newResult)
        }
    }
    
    func saveLeagueToFavorite(){
        if coredataRepo == nil {
            coredataRepo = CoreDataRepoImpl.shared
        }
        if let coredataRepo {
            coredataRepo.saveLeagueToFavorite(leagueId: Int32(league.leagueKey), leagueName: league.leagueName, leagueImage: league.leagueImage, leagueType: sportsType.rawValue)
        }
    }
}
