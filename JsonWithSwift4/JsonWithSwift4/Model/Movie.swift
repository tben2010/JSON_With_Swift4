//
//  Movie.swift
//  JsonWithSwift4
//
//  Created by tben on 01.08.17.
//  Copyright © 2017 tben. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let id: String
    let assets: [Asset]
}
