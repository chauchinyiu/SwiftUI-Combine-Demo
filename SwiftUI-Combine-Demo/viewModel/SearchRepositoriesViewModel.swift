//
//  SearchRepositoriesViewModel.swift
//  SwiftUI-Combine-Demo
//
//  Created by Chinyiu Chau on 07.07.19.
//  Copyright © 2019 Chinyiu Chau. All rights reserved.
//


import Combine
import SwiftUI
//@MainActor, make sure the value being published will be in main thread
@MainActor class SearchRepositoriesViewModel: ObservableObject {
    
    let client = GithubServicesClient()
    var subscriber: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
   
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
        AnyCancellable( $query
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink(receiveValue: { query in
                guard !query.isEmpty else {
                    self.repositories = []
                    return
                }
              Task {
                  await self.searchAwait()
              }
            
         
            })).store(in: &cancellables)
   
    }
   
      func search() {
        
        guard requestingQuery != query else {
            return
        }
        print("Searching keyword: ", query)
        self.subscriber = self.client.request(query: query)
             .catch { _ in Just([]) }
             .assign(to: \.repositories, on: self)
             
        requestingQuery = query
    }
    
    func searchAwait() async   {
        guard requestingQuery != query else {
            return
        }
        print("Searching keyword async ", query)
        requestingQuery = query
        do {
            self.repositories = try await self.client.request(query: query)
        } catch {
            print("failed to search repository")
        }
    }
}
    
    



