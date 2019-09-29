//
//  RepositoryRowViewModel.swift
//  SwiftUI-Combine-Demo
//
//  Created by Chinyiu Chau on 08.07.19.
//  Copyright © 2019 Chinyiu Chau. All rights reserved.
//

import SwiftUI
import Combine

final class RepositoryRowViewModel: ObservableObject{
    
   @Published private(set) var image = UIImage(named: "placeholder")
    
    func lazyLoadImage(url : URL){
        URLSession.shared.dataTask( with: url, completionHandler: { (data, _, _) -> Void in
            DispatchQueue.main.async {
                if let data = data, let img = UIImage(data: data) {
                    self.image = img
                }
            }
        }
        ).resume()
    }
}
