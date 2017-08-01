//
//  Assets.swift
//  JsonWithSwift4
//
//  Created by tben on 01.08.17.
//  Copyright © 2017 tben. All rights reserved.
//

import Foundation

struct Asset: Decodable {
    let url: String
    let accessibilityLabel: String
    let type: String
    let id: String
    let timeOfDay: String
}
