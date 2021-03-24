//
//  NetworkService.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/24/21.
//

import Foundation


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


final class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    private let urlSession = URLSession.shared
    private let baseUrl = URL(string: "https://m.citadele.lv/cimo/p/currate")
    private let jsonDecoder = JSONDecoder()
    
    enum NetworkServiceError: Error {
        case apiError
        case noData
        case invalidEndpoint
        case invalidResponse
        case decodeError
    }
    
    
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

    
    private func fetchData<T: Decodable>(from request: URLRequest?, completion: @escaping (Result<T, NetworkServiceError>) -> Void) {
        guard let request = request else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        urlSession.dataTask(with: request) { result in
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    completion(.failure(.invalidEndpoint))
                    return
                }
                do {
                    let values = try self.jsonDecoder.decode(T.self, from: data)
                    completion(.success(values))
                } catch {
                    debugPrint(error.localizedDescription)
                    completion(.failure(.decodeError))
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion(.failure(.apiError))
            }
        }.resume()
    }
    
    func fetchCurrencies(with queries: Queries? = nil, result: @escaping (Result<Currencies, NetworkServiceError>) -> Void) {

        var request: URLRequest?
        
        if let queries = queries {
            let urlWithQueries = prepareQueries(queries, in: baseUrl)
            request = prepareRequest(from: urlWithQueries)
        } else {
            request = prepareRequest(from: baseUrl)
        }
        
        fetchData(from: request, completion: result)
    }
}
