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
    var leagueId: Int

    init(sportsType: APIConstants.Sport, SportsRepo: any SportRepoProtocol, leagueId: Int) {
        self.sportsType = sportsType
        self.SportsRepo = SportsRepo
        self.leagueId = leagueId
    }

    func getData() {
        getFixtures()
        getTeamsOrPlayers()
    }

    private func getFixtures() {
        SportsRepo.getFixtures(leagueId: leagueId) { [weak self] result in
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
        SportsRepo.getTeamsOrPlayers(leagueId: leagueId) { [weak self] result in
            guard let result = result, let self = self else { return }
            let newResult = result.compactMap {
                TeamOrPlayerMapper.MapToTeamOrPlayer(forSport: self.sportsType, teamOrPlayer: $0)
            }
            view?.updateData(teamOrPlayer: newResult)
        }
    }
}
