//
//  ObjectHits.swift
//  MVVM-Swift
//
//  Created by Luis Larrea on 7/31/21.
//

import Foundation

struct ObjectHits: Codable {
    var articulos        : [ObjectArticle]? = []
    var nbHits           : Int?
    var page             : Int?
    var nbPages          : Int?
    var hitsPerPage      : Int?
    var exhaustiveNbHits : Bool?
    var query            : String?
    var params           : String?
    var processingTimeMS : Int?
        
    enum CodingKeys: String, CodingKey {
        case articulos = "hits"
    } 
}
