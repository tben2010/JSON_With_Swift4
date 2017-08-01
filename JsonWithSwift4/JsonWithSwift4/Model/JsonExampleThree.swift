//
//  JsonExampleThree.swift
//  JsonWithSwift4
//
//  Created by tben on 01.08.17.
//  Copyright © 2017 tben. All rights reserved.
//

import Foundation


struct WebsiteDescription: Decodable {
    let name: String
    let description: String
    let courses: [CourseThree]
}

struct CourseThree: Decodable {
    let id: Int
    let name: String
    let link: String
    let imageUrl: String
}
