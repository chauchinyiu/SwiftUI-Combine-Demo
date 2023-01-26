//
//  Repository.swift
//  Rxswift-Demo
//
//  Created by Chinyiu Chau on 05.07.19.
//  Copyright © 2019 Chinyiu Chau. All rights reserved.
//

import Foundation
import SwiftUI

struct Repository: Decodable, Identifiable {
    var id: Int64
    var full_name: String
    var description: String?
    var stargazers_count: Int = 0
    var language: String?
    var owner: User
    var html_url: URL
}

 
