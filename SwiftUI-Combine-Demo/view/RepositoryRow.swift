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
    @ObservedObject var viewModel: RepositoryRowViewModel = RepositoryRowViewModel()
    @State var repository: Repository

   let fontsize: CGFloat = 18
   let imagesize: CGFloat = 50
 
   var body: some View {
        HStack {
           setImage()
                .resizable()
                .renderingMode(.original)
                .animation(.default)
                .aspectRatio(contentMode: .fit)
                .frame(width: imagesize, height: imagesize)
 
            Text(repository.full_name)
                .font(Font.system(size: fontsize).bold())
                
            
            Spacer()
        }.frame(width:200, height: 60, alignment: .center)
    }
 
// Part 1: Synchronously loading image
//    func setImage() -> Image {
//        var result:Image? = nil
//        if let data = try? Data(contentsOf: repository.owner.avatar_url) {
//            if let image = UIImage(data: data) {
//                result = Image(uiImage: image)
//            }}
//        if  (result == nil){
//            result = Image(uiImage: UIImage(named: "placeholder", in: Bundle.main, compatibleWith: nil) ?? UIImage())
//        }
//        print("thread :::: \(Thread.current)")
//        return result!
//    }
    
// Part 2: Asynchronously loading image  (lazy loading)
    func setImage() -> Image {
        viewModel.lazyLoadImage(url: repository.owner.avatar_url)
        return Image(uiImage:viewModel.image ?? UIImage())
    }
    

}


#if DEBUG
struct RepositoryRow_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryRow(repository: Repository(id: Int64(UUID().hashValue), full_name: "test 1", description: "test description", stargazers_count: 4, language: "swift", owner: User(id: Int64(UUID().hashValue), login: "test", avatar_url: URL(string: "https://avatars3.githubusercontent.com/u/324574?v=4")!), html_url: URL(string: "https://github.com/openstack")!))
    }
}
#endif
