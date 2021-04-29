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
            .tryMap { data, response -> Response<T> in
                let value = try decoder.decode(T.self, from: data)
                return Response(value: value, response: response)
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
