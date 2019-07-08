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
    @ObjectBinding var viewModel: RepositoryRowViewModel = RepositoryRowViewModel()
    @State var repository: Repository

 
   let fontsize: CGFloat = 18
   let imagesize: CGFloat = 50
 
   var body: some View {
        HStack {
           setImage()
                .resizable()
                .renderingMode(.original)
                .animation(.basic())
                .aspectRatio(contentMode: .fit)
                .frame(width: fontsize, height: imagesize)
 
            Text(repository.full_name)
                .font(Font.system(size: fontsize).bold())
            
            Spacer()
        }.tapAction({
            UIApplication.shared.open(self.repository.html_url, options:  [:], completionHandler: nil)
        }).frame(height: 60)
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


