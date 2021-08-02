//
//  ObjectResult.swift
//  MVVM-Swift
//
//  Created by Luis Larrea on 7/31/21.
//

import Foundation

struct ObjectResult: Codable {
    var author      : ObjectValues?
    var commentText : ObjectValues?
    var storyTitle  : ObjectValues?
    var storyUrl    : ObjectValues?
        
    enum CodingKeys: String, CodingKey {
        case author      = "author"
        case commentText = "comment_text"
        case storyTitle  = "story_title"
        case storyUrl    = "story_url"
    }
}
