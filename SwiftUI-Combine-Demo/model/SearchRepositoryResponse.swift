//
//  SearchRepositoryResponse.swift
//  Rxswift-Demo
//
//  Created by Chinyiu Chau on 05.07.19.
//  Copyright © 2019 Chinyiu Chau. All rights reserved.
//
import Foundation

struct SearchRepositoryResponse: Decodable {
    var items: [Repository]
}
