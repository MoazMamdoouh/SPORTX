//
//  FootballRepoWithMockTests.swift
//  SPORTXTests
//
//  Created by Omar Abdelaziz on 22/05/2025.
//

import XCTest
@testable import SPORTX

final class FootballRepoWithMockTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFootballGetLeagues() throws {
        let mockData = FootballLeague(league_key: 1, league_name: "Premier League", league_logo: nil)
        let MockResponseData = FootballLeagueResponse(success: 1, result: [mockData])
        let footballRepo = FootballRepo(networkManager: MockNetworkManager(shouldReturnError: false, mockData: MockResponseData))
        
        footballRepo.getLeagues { result in
            XCTAssertNotNil(result)
            XCTAssertEqual(result?.count, 1)
            XCTAssertEqual(result?.first?.league_key, 1)
            XCTAssertNil(result?.first?.league_logo)

        }
    }
    
    func testFootballGetLeaguesShouldReturnNil() throws {
        let mockData = FootballLeague(league_key: 1, league_name: "Premier League", league_logo: nil)
        let MockResponseData = FootballLeagueResponse(success: 1, result: [mockData])
        let footballRepo = FootballRepo(networkManager: MockNetworkManager(shouldReturnError: true, mockData: MockResponseData))
        
        footballRepo.getLeagues { result in
            XCTAssertNil(result)
        }
    }
    
    func testFootballGetFixtures() throws {
        let mockData = FootballFixture(event_date: "", event_time: "", event_home_team: "omar", home_team_key: 1, event_away_team: "moaz", away_team_key: 2, event_final_result: nil, event_status: nil, league_name: "Premier League", home_team_logo: nil, away_team_logo: nil, league_logo: nil)
        
        let MockResponseData = FootballFixtureResponse(success: 1, result: [mockData])
        let footballRepo = FootballRepo(networkManager: MockNetworkManager(shouldReturnError: false, mockData: MockResponseData))
        
        footballRepo.getFixtures(leagueId: 2, completion:  { result in
            XCTAssertNotNil(result)
            XCTAssertEqual(result?.count, 1)
            XCTAssertEqual(result?.first?.event_home_team, "omar")
            XCTAssertEqual(result?.first?.away_team_key, 2)
            XCTAssertEqual(result?.first?.league_name, "Premier League")
            XCTAssertNil(result?.first?.league_logo)

        })
    }

    func testFootballGetTeams() throws {
        let mockData = FootballTeam(team_key: 1, team_name: "omar", team_logo: nil, players: [], coaches: [])
        let MockResponseData = FootballTeamResponse(success: 1, result: [mockData])
        let footballRepo = FootballRepo(networkManager: MockNetworkManager(shouldReturnError: false, mockData: MockResponseData))
        
        footballRepo.getTeamsOrPlayers(leagueId: 2, completion:  { result in
            XCTAssertNotNil(result)
            XCTAssertEqual(result?.count, 1)
            XCTAssertEqual(result?.first?.team_key, 1)
            XCTAssertEqual(result?.first?.team_name, "omar")
            XCTAssertEqual(result?.first?.players.count, 0)
            XCTAssertNil(result?.first?.team_logo)

        })
    }
    
    
    
}
