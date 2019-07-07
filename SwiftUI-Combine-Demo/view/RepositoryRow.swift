//
//  RepositoryRow.swift
//  SwiftUI-Combine-Demo
//
//  Created by Chinyiu Chau on 07.07.19.
//  Copyright © 2019 Chinyiu Chau. All rights reserved.
//

import SwiftUI
import UIKit

struct RepositoryRow : View {
    @ObjectBinding var viewModel: GithubSearchViewModel
    @State var repository: Repository
    let fontsize: CGFloat = 18
    let imagesize: CGFloat = 50
    var body: some View {
        
        HStack {
            self.loadImage()
                .resizable()
                .renderingMode(.original)
                .animation(.basic())
                .aspectRatio(contentMode: .fit)
                .frame(width: imagesize, height: imagesize)
 
            Text(repository.full_name)
                .font(Font.system(size: fontsize).bold())
            
            Spacer()
        }.tapAction({
            UIApplication.shared.open(self.repository.html_url, options:  [:], completionHandler: nil)
        }).frame(height: 60)
    }
    
    func loadImage() -> Image {
        var result:Image? = nil
        if let data = try? Data(contentsOf: repository.owner.avatar_url) {
            if let image = UIImage(data: data) {
                result = Image(uiImage: image)
            }}
        if  (result == nil){
            result = Image(uiImage: UIImage(named: "placeholder", in: Bundle.main, compatibleWith: nil) ?? UIImage())
        }
        return result!
        
    }
}


