//
//  GithubSearchView.swift
//  SwiftUI-Combine-Demo
//
//  Created by Chinyiu Chau on 07.07.19.
//  Copyright © 2019 Chinyiu Chau. All rights reserved.
//

import SwiftUI
import Combine

struct GithubSearchView : View {
    @ObservedObject var viewModel = GithubSearchViewModel()
    
     var body: some View {
     NavigationView {
            VStack {
                SearchBar(text: $viewModel.query)
                List(viewModel.repositories){ repo in
                    RepositoryRow( repository: repo)
                } 
            }
            .navigationBarTitle(Text("Github Search"))
        }
    }
}

#if DEBUG
struct GithubSearchView_Previews: PreviewProvider {
    
    static var previews: some View {
         mockSearchView()
    }
    
    static func mockSearchView() -> GithubSearchView {
        let searchView = GithubSearchView()
        searchView.viewModel.query = "swift"
        let repos = [ Repository(id: Int64(UUID().hashValue), full_name: "test 1", description: "test description", stargazers_count: 4, language:"swift", owner: User(id: Int64(UUID().hashValue), login: "test", avatar_url: URL(string: "https://avatars3.githubusercontent.com/u/324574?v=4")!), html_url: URL(string: "https://github.com/openstack")!),
         Repository(id: Int64(UUID().hashValue), full_name: "test 2", description: "test description", stargazers_count: 4, language: "swift", owner: User(id: Int64(UUID().hashValue), login: "test", avatar_url: URL(string: "https://avatars3.githubusercontent.com/u/324574?v=4")!), html_url: URL(string: "https://github.com/openstack")!),
         Repository(id: Int64(UUID().hashValue), full_name: "test 3", description: "test description", stargazers_count: 4, language: "swift", owner: User(id: Int64(UUID().hashValue), login: "test", avatar_url: URL(string: "https://avatars3.githubusercontent.com/u/324574?v=4")!), html_url: URL(string: "https://github.com/openstack")!)]
        
        searchView.viewModel.repositories = repos
        return searchView
    }
}

#endif
