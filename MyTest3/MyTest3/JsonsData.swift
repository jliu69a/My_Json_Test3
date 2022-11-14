//
//  JsonsData.swift
//  MyTest3
//
//  Created by Johnson Liu on 11/14/22.
//

import UIKit

struct Book: Codable {
    var id: String
    var title: String
    var author: Author
}

struct Author: Codable {
    var id: String
    var last_name: String
    var first_name: String
    var location: Location
}

struct Location: Codable {
    var id: String
    var city: String
    var nation: String
}
