//
//  NetworkProtocol.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 15/05/2025.
//

protocol NetworkManagerProtocol {
    func fetchData<T: Decodable>(
        sport: APIConstants.Sport,
        met: APIConstants.Met,
        parameters: [String: String],
        responseType: T.Type,
        completion: @escaping (T?) -> Void
    ) -> Void
}
