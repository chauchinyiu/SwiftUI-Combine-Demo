//
//  SearchBar.swift
//  SwiftUI-Combine-Demo
//
//  Created by Chinyiu Chau on 07.07.19.
//  Copyright © 2019 Chinyiu Chau. All rights reserved.
//

import SwiftUI

struct SearchBar : View {
    @Binding var text: String
    
    var viewModel: GithubSearchViewModel
    var body: some View {
        ZStack {
            Color.gray
            HStack {
           
                TextField($text)
               .padding([.leading, .trailing, .top, .bottom], 8)
                    .background(Color.white.opacity(0.4))
                    .foregroundColor(Color.white)
                    .cornerRadius(8)

       
                
            }
            .padding([.leading, .trailing], 16)
            
        }
        .frame(height: 64)
    }
}

 