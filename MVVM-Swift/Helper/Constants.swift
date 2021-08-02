//
//  Constants.swift
//  MVVM-Swift
//
//  Created by Luis Larrea on 7/30/21.
//

import Foundation

struct Constants {
    static let TAG = "M4NU_"
    
    struct URL {
        static let API_PRO = ""
        static let API_DEV = "https://hn.algolia.com/api/v1/"
        static let IMAGES  = ""        
    }
    
    struct SERVICES {
        static let LIST_ARTICLES = "search_by_date?query=mobile"
    }
    
    struct STRING_KEYS {
        static let TEMP_DATA   = TAG + "TEMP_DATA"
        static let DELETE_DATA = TAG + "DELETE_DATA"
    }
}
