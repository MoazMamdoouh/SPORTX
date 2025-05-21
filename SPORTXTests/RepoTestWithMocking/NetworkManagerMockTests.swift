//
//  NetworkManagerMockTest.swift
//  SPORTXTests
//
//  Created by Omar Abdelaziz on 22/05/2025.
//

@testable import SPORTX
import XCTest

final class NetworkManagerMockTests: XCTestCase {
    let mockNetworkManager = MockNetworkManager(shouldReturnError: true, mockData: MockData(id: 1, name: "omar"))

    let mockNetworkManager2 = MockNetworkManager(shouldReturnError: false, mockData: MockData(id: 1, name: "omar"))

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testFetchDataShouldReturnNil() {
        mockNetworkManager.fetchData(
            sport: .football,
            met: .leagues,
            parameters: [:],
            responseType: MockData.self
        ) { result in
            XCTAssertNil(result)
        }
    }

    func testFetchDataShouldReturnWithData() {
        mockNetworkManager2.fetchData(
            sport: .football,
            met: .leagues,
            parameters: [:],
            responseType: MockData.self
        ) { result in
            XCTAssertNotNil(result)
            XCTAssertEqual(result?.name, "omar")
            XCTAssertEqual(result?.id, 1)
        }
    }

    func testFetchDataTypeMismatch() {
        struct WrongResponse: Decodable {
            let name: String
        }
        mockNetworkManager2.fetchData(
            sport: .football,
            met: .leagues,
            parameters: [:],
            responseType: WrongResponse.self
        ) { result in
            XCTAssertNil(result)
        }
    }
}
