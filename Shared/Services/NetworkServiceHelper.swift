//
//  NetworkServiceHelper.swift
//  CurRates
//
//  Created by Maksim Kalik on 4/29/21.
//

import Foundation

final class NetworkServiceHelper {
    
    static let shared = NetworkServiceHelper()
    private init() {}
    
    enum Query: String {
        case language
        case location
    }
    
    enum HTTPMethod: String {
        case post = "POST"
    }
    
    typealias Queries = [Query : Locale.Language]
    
    func prepareQueries(_ queries: Queries, in url: URL?) -> URL? {
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
    
    func prepareRequest(from url: URL?, httpMethod: HTTPMethod) -> URLRequest? {
        guard let url = url else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        return request
    }
}
