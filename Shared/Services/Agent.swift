//
//  Agent.swift
//  CurRates
//
//  Created by Maksim Kalik on 4/29/21.
//

import Foundation
import Combine

struct Agent {
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    func run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                let value = try decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}


final class CitadeleApi {

    static let shared = CitadeleApi()
    private init() {}
    
    private let agent = Agent()
    private let baseUrl = URL(string: Constants.baseUrl)
    
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
    
    private func prepareQueries(_ queries: Queries, in url: URL?) -> URL? {
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
    
    private func prepareRequest(from url: URL?) -> URLRequest? {
        guard let url = url else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return request
    }
    
    func fetchCurrencies(with queries: Queries? = nil) -> AnyPublisher<Currencies, Error> {
        var request: URLRequest?
        
        if let queries = queries {
            let urlWithQueries = prepareQueries(queries, in: baseUrl)
            request = prepareRequest(from: urlWithQueries)
        } else {
            request = prepareRequest(from: baseUrl)
        }
        
        return agent
            .run(request!)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
