//
//  GithubServices.swift
//  Rxswift-Demo
//
//  Created by Chinyiu Chau on 07.07.19.
//  Copyright © 2019 Chinyiu Chau. All rights reserved.
//


import SwiftUI
import Combine
import Foundation

class GithubServicesClient {
    
    func request(query: String) -> AnyPublisher<[Repository], Error> {
        guard let url = url(query)
            else { preconditionFailure("Can't create url for query: \(query)") }
  
        let decoder = JSONDecoder()
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .receive(on: RunLoop.main)
            .decode(type: SearchRepositoryResponse.self, decoder: decoder)
            .map { $0.items }
            .eraseToAnyPublisher()
        
    }
    
    private func url(_ query : String) -> URL? {
        var urlComponents = URLComponents(string: "https://api.github.com/search/repositories")
        
        var queryItems: [URLQueryItem] {
            return [
                .init(name: "q", value: query),
                .init(name: "order", value: "desc")
            ]
        }
        urlComponents?.queryItems = queryItems;
        return urlComponents?.url
    }
}
