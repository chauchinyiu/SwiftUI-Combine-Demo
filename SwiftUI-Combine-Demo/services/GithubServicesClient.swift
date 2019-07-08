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
    let baseUrl:String = "https://api.github.com/"
    
    func search(query: String,  completion: @escaping (_ result: [Repository], _ error: Error?) -> Void) {
        guard !query.isEmpty else {
            completion([],nil)
            return
        }
        
        var urlComponents = URLComponents(string: self.baseUrl + "search/repositories")!
        
        var queryItems: [URLQueryItem] {
            return [
                .init(name: "q", value: query),
                .init(name: "order", value: "desc")
            ]
        }
        urlComponents.queryItems = queryItems;
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                   completion([],error)
                return
            }
            
            DispatchQueue.main.async {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(SearchRepositoryResponse.self, from: data)
                    completion(response.items,nil)
                } catch let err {
                    completion([],err)
                    print(err)
                }
            }
        }
        task.resume();
    }

}
