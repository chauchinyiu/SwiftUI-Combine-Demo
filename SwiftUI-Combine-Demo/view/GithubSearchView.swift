//
//  GithubSearchView.swift
//  SwiftUI-Combine-Demo
//
//  Created by Chinyiu Chau on 07.07.19.
//  Copyright © 2019 Chinyiu Chau. All rights reserved.
//

import SwiftUI

struct GithubSearchView : View {
    @ObjectBinding var viewModel = GithubSearchViewModel()
 

     var body: some View {
        NavigationView {
            VStack {
  
                SearchBar(text: viewModel[\.query], viewModel: viewModel)
                
                List(viewModel.repositories) { repo in
                    RepositoryRow(viewModel: self.viewModel, repository: repo)
                      
                } 
            }
            .navigationBarTitle(Text("Github Repositories"))
        }
    }
}


