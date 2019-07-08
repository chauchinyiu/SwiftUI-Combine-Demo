//
//  GithubSearchViewModel.swift
//  SwiftUI-Combine-Demo
//
//  Created by Chinyiu Chau on 07.07.19.
//  Copyright © 2019 Chinyiu Chau. All rights reserved.
//

import SwiftUI
import Combine

final class GithubSearchViewModel: BindableObject {
    let client = GithubServicesClient()
    var didChange = PassthroughSubject<GithubSearchViewModel, Never>()
    var searchTask: DispatchWorkItem?
    private(set) var repositories = [Repository]() {
        didSet { didChange.send(self) }
    }
    
    let baseUrl:String = "https://api.github.com/"

    var query = "" {
        didSet {
            didChange.send(self)
            if(oldValue.isEmpty){
                self.repositories = []
            }else{
                print("typing :: " + self.query)
                //Implementation Of throttle machanism
                self.searchTask?.cancel()
                // Replace previous task with a new one
                let task = DispatchWorkItem { [weak self] in
                    self?.search()
                    print("search :: " + (self?.query ?? ""))
                }
                self.searchTask = task
                // Execute task in 1 second (if not cancelled !)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: task)
            } 
        }
    }

    func search() {
        client.search(query: query) { (result, error) in
            if(error != nil) {
                print("error :" + error.debugDescription)
            } else{
                 self.repositories = result
            }
        }
    }
 
}
