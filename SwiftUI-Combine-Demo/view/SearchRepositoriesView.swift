//
//  GithubSearchView.swift
//  SwiftUI-Combine-Demo
//
//  Created by Chinyiu Chau on 07.07.19.
//  Copyright © 2019 Chinyiu Chau. All rights reserved.
//

import SwiftUI
import Combine

struct SearchRepositoriesView : View {
    @ObservedObject var viewModel = SearchRepositoriesViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.query){
                    print("enter tapped !!!!")
//                    self.viewModel.search()
                    
                    Task {
                        await self.viewModel.searchAwait()
                    }
                }
                List(viewModel.repositories){ repo in
                    
                    //open WebView in the app
                    NavigationLink(destination:WebView(request:URLRequest(url: repo.html_url))) {
                        RepositoryRow( repository: repo)
                    }
                    
//                    //open safari app
//                    RepositoryRow( repository: repo).onTapGesture {
//                        UIApplication.shared.open(repo.html_url, options:  [:], completionHandler: nil)
//                    }
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
    
    static func mockSearchView() -> SearchRepositoriesView {
        let searchView = SearchRepositoriesView()
        searchView.viewModel.query = "swift"
        let repos = [ Repository(id: Int64(UUID().hashValue), full_name: "test 1", description: "test description", stargazers_count: 4, language:"swift", owner: User(id: Int64(UUID().hashValue), login: "test", avatar_url: URL(string: "https://avatars3.githubusercontent.com/u/324574?v=4")!), html_url: URL(string: "https://github.com/openstack")!),
                      Repository(id: Int64(UUID().hashValue), full_name: "test 2", description: "test description", stargazers_count: 4, language: "swift", owner: User(id: Int64(UUID().hashValue), login: "test", avatar_url: URL(string: "https://avatars3.githubusercontent.com/u/324574?v=4")!), html_url: URL(string: "https://github.com/openstack")!),
                      Repository(id: Int64(UUID().hashValue), full_name: "test 3", description: "test description", stargazers_count: 4, language: "swift", owner: User(id: Int64(UUID().hashValue), login: "test", avatar_url: URL(string: "https://avatars3.githubusercontent.com/u/324574?v=4")!), html_url: URL(string: "https://github.com/openstack")!)]
        
        searchView.viewModel.repositories = repos
        return searchView
    }
}

#endif
