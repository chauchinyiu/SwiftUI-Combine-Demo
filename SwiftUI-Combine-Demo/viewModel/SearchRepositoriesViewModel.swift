//
//  GithubSearchViewModel.swift
//  SwiftUI-Combine-Demo
//
//  Created by Chinyiu Chau on 07.07.19.
//  Copyright © 2019 Chinyiu Chau. All rights reserved.
//

 
import Combine
import SwiftUI
final class SearchRepositoriesViewModel: ObservableObject {
    
    let client = GithubServicesClient()
    var subscriber: AnyCancellable?
 
    @Published  var repositories = [Repository]()

    @Published  var query = "" {
        didSet {
            self.search()
            print(query)
        }
    }

   func search() {
    _ = AnyCancellable( $query
           .removeDuplicates()
           .debounce(for: 1, scheduler: DispatchQueue.main)
           .sink(receiveValue: { query in
            self.subscriber = self.client.request(query: query)
                   .catch { _ in Just([]) }
                   .assign(to: \.repositories, on: self)
           }))
 
    }

 
}
