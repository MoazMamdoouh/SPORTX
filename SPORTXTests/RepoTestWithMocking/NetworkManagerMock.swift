//
//  NetworkManagerMock.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 22/05/2025.
//

import Foundation
@testable import SPORTX

struct MockData: Decodable{
    let id: Int
    let name: String
}
class MockNetworkManager: NetworkManagerProtocol {
    var shouldReturnError: Bool
    var mockData: Any
    
    init(shouldReturnError: Bool, mockData: Any) {
        self.shouldReturnError = shouldReturnError
        self.mockData = mockData
    }

    func fetchData<T: Decodable>(
        sport: APIConstants.Sport,
        met: APIConstants.Met,
        parameters: [String: String],
        responseType: T.Type,
        completion: @escaping (T?) -> Void
    ) {
        if shouldReturnError {
            completion(nil)
            return
        }

        if let mockData = mockData as? T {
            completion(mockData)
        } else {
            completion(nil)
        }
    }
}
