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
    var cancellables = Set<AnyCancellable>()
    let q = DispatchQueue.main //DispatchQueue(label: "debounce-queue")
    var requestingQuery = ""
    @Published var repositories = [Repository]() {
        didSet {
            requestingQuery = ""
        }
    }
    @Published var query = "" {
        didSet {
            print(query)
        }
    }
    // set up debounce for query string and publish the results of repositiories
    init() {
        _ = AnyCancellable( $query
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink(receiveValue: { query in
                guard !query.isEmpty else {
                    self.repositories = []
                    return
                }
               self.search()
            })).store(in: &cancellables)
    }
   
    func search() {
        
        guard requestingQuery != query else {
            return
        }
        print("Searching keyword: ", query)
        self.subscriber = self.client.request(query: query)
             .removeDuplicates()
             .catch { _ in Just([]) }
             .assign(to: \.repositories, on: self)
        requestingQuery = query
    }
}

