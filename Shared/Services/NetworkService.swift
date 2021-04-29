//
//  Agent.swift
//  CurRates
//
//  Created by Maksim Kalik on 4/29/21.
//

import Foundation
import Combine

enum NetworkService {
    static let agent = Agent()
    
    enum FailureReason: Error {
        case sessionFailed(error: URLError)
        case decodingFailed
        case invalidEndpoint
        case other(Error)
    }
    
    static func fetchData<Output: Decodable>(from request: URLRequest?) -> AnyPublisher<Output, FailureReason> {
        
        guard let request = request else {
            return Fail(error: FailureReason.invalidEndpoint).eraseToAnyPublisher()
        }
        
        return agent
            .run(request)
            .map(\.value)
            .mapError({ error in
                switch error {
                case is Swift.DecodingError:
                    return .decodingFailed
                case let urlError as URLError:
                    return .sessionFailed(error: urlError)
                default:
                    return .other(error)
                }
            })
            .eraseToAnyPublisher()
    }
}

extension NetworkService {
    
    static let helper = NetworkServiceHelper.shared

    static func fetchCurrencies(with queries: NetworkServiceHelper.Queries? = nil) -> AnyPublisher<Currencies, FailureReason> {
        let baseUrl = URL(string: Constants.baseUrl)
        var request: URLRequest?
        
        if let queries = queries {
            let urlWithQueries = helper.prepareQueries(queries, in: baseUrl)
            request = helper.prepareRequest(from: urlWithQueries, httpMethod: .post)
        } else {
            request = helper.prepareRequest(from: baseUrl, httpMethod: .post)
        }
        
        return fetchData(from: request)
    }
}
