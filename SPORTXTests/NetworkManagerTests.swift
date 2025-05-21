//
//  NetworkManagerTests.swift
//  SPORTXTests
//
//  Created by Omar Abdelaziz on 22/05/2025.
//

import XCTest
@testable import SPORTX

final class NetworkManagerTests: XCTestCase {
    
    let networkManager = NetworkManager.shared
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testApiCall() throws {
        let expectation = expectation(description: "Wait for network call")

        
        networkManager.fetchData(sport: .football, met: .leagues, parameters: [:], responseType: FootballLeagueResponse.self) { result in
            if result == nil {
                XCTFail()
                return
            }
            if let result {
                XCTAssertEqual(result.result.count, 55)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5)
    }
}
