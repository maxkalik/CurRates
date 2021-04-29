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

// MARK: - Helpers

extension NetworkService {
    static let baseUrl = URL(string: Constants.baseUrl)
 
    enum Language: String {
        case LV
        case EN
        case RU
    }

    enum Query: String {
        case language
        case location
    }
    
    typealias Queries = [Query : Language]
    
    static func prepareQueries(_ queries: Queries, in url: URL?) -> URL? {
        guard let url = url else {
            return nil
        }
        
        var queryItems = [URLQueryItem]()
        for query in queries {
            queryItems.append(URLQueryItem(name: query.key.rawValue, value: query.value.rawValue))
        }
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
    
    static func prepareRequest(from url: URL?) -> URLRequest? {
        guard let url = url else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return request
    }
}

extension NetworkService {

    static func fetchCurrencies(with queries: Queries? = nil) -> AnyPublisher<Currencies, FailureReason> {
        var request: URLRequest?
        
        if let queries = queries {
            let urlWithQueries = prepareQueries(queries, in: baseUrl)
            request = prepareRequest(from: urlWithQueries)
        } else {
            request = prepareRequest(from: baseUrl)
        }
        
        return fetchData(from: request)
    }
}
