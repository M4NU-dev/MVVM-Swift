//
//  ObjectValues.swift
//  MVVM-Swift
//
//  Created by Luis Larrea on 7/31/21.
//

import Foundation

struct ObjectValues: Codable {
    var value            : String?
    var matchLevel       : String?
    var fullyHighlighted : Bool?
    var matchedWords     : [String]? = []
}
