//
//  NetworkManager.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 15/05/2025.
//

import Alamofire
import Foundation

final class NetworkManager : NetworkManagerProtocol {
    static let shared = NetworkManager()
    private init() {}

    func fetchData<T: Decodable>(
        sport: APIConstants.Sport,
        met: APIConstants.Met,
        parameters: [String: String],
        responseType: T.Type,
        completion: @escaping (T?) -> Void
    ) {
        var fullParams = parameters
        fullParams["met"] = met.rawValue
        fullParams["APIkey"] = APIConstants.apiKey
        
        print(fullParams)

        let url = "\(APIConstants.baseURL)/\(sport.rawValue)/"

        var fullURL = URLComponents(string: url)
        fullURL?.queryItems = fullParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        guard let fullURL = fullURL else { return }
        print(fullURL)


        AF.request(fullURL)
            .validate()
            .responseData { response in
                switch response.result {
                case let .success(data):
                    do {
                        let decodedResponse = try JSONDecoder().decode(responseType, from: data)
                        completion(decodedResponse)
                    } catch let ex as NSError {
                        print("Decoding error: \(ex.localizedDescription)")
                        completion(nil)
                    }
                case let .failure(error):
                    print("Network request failed: \(error.localizedDescription)")
                    completion(nil)
                }
            }
    }
}
