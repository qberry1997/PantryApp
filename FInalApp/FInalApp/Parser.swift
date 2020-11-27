//
//  Parser.swift
//  FInalApp
//
//  Created by Quinn Berry on 11/26/20.
//  Copyright © 2020 Quinn Berry. All rights reserved.
//

import Foundation

struct Parser: Codable {
    var text: String?
    var parsed: [Parsed]?
}

struct Parsed: Codable {
    var food: Food?
}

struct Food: Codable {
    var foodId: String?
    var uri: String?
    var label: String?
    var nutrients: Nutrients?
}

struct Nutrients: Codable {
    var ENERC_KCAL: Double?
    var PROCNT: Double?
    var FAT: Double?
    var CHOCDF: Double?
    var FIBTG: Double?
}
