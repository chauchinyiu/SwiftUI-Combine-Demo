//
//  RepositoryRow.swift
//  SwiftUI-Combine-Demo
//
//  Created by Chinyiu Chau on 07.07.19.
//  Copyright © 2019 Chinyiu Chau. All rights reserved.
//

import SwiftUI
import UIKit
import Combine

struct RepositoryRow : View {
   @State var repository: Repository

   let fontsize: CGFloat = 18
   let imagesize: CGFloat = 50
 
   var body: some View {
        HStack {
 
            AsyncImage( url: repository.owner.avatar_url,
                         content: { image in
                             image.resizable()
                                  .aspectRatio(contentMode: .fit)
                                  .frame(maxWidth: imagesize, maxHeight: imagesize)
                         },
                         placeholder: {
                             EmptyView()
                         }
                     )
 
 
            Text(repository.full_name)
                .font(Font.system(size: fontsize).bold())
                
            
            Spacer()
        }.frame(width:200, height: 60, alignment: .center)
    }
 
}


#if DEBUG
struct RepositoryRow_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryRow(repository: Repository(id: Int64(UUID().hashValue), full_name: "test 1", description: "test description", stargazers_count: 4, language: "swift", owner: User(id: Int64(UUID().hashValue), login: "test", avatar_url: URL(string: "https://avatars3.githubusercontent.com/u/324574?v=4")!), html_url: URL(string: "https://github.com/openstack")!))
    }
}
#endif
