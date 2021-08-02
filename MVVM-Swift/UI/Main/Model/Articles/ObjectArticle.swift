//
//  ObjectArticle.swift
//  MVVM-Swift
//
//  Created by Luis Larrea on 7/31/21.
//

import Foundation

struct ObjectArticle: Codable {
    var createdAt       : String?
    var title           : String?
    var url             : String?
    var author          : String?
    var points          : Int?
    var storyText       : String?
    var commentText     : String?
    var numComments     : Int?
    var storyId         : Int?
    var storyTitle      : String?
    var storyUrl        : String?
    var parentId        : Int?
    var createdAtI      : Int?
    var tags            : [String]? = []
    var objectID        : String?
    var HighlightResult : ObjectResult?
    
    
    enum CodingKeys: String, CodingKey {
        case createdAt       = "created_at"
        case storyText       = "story_text"
        case commentText     = "comment_text"
        case numComments     = "num_comments"
        case storyId         = "story_id"
        case storyTitle      = "story_title"
        case storyUrl        = "story_url"
        case parentId        = "parent_id"
        case createdAtI      = "created_at_i"
        case tags            = "_tags"
        case HighlightResult = "_highlightResult"        
    }
    
    func getPublishedDate() -> String {
        if let articleDate = self.createdAt {
            var dateText = ""
                        
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZ"
            let date = dateFormatter.date(from: articleDate)
            
            let distanceBetweenDates: TimeInterval? = Date().timeIntervalSince(date!)
            
            let hoursBetweenDates = Int((distanceBetweenDates! / secondsInAnHour))
            let minutesBetweenDates = (Int(distanceBetweenDates!) - hoursBetweenDates * 3600) / 60
            let daysBetweenDates = Int((distanceBetweenDates! / secondsInDays))
            
            if hoursBetweenDates <= 24 {
                if hoursBetweenDates == 1 {
                    dateText = "hace \(hoursBetweenDates) hora"
                } else if hoursBetweenDates > 1 {
                    dateText = "hace \(hoursBetweenDates) horas"
                } else {
                    if minutesBetweenDates <= 1 {
                        dateText = "hace \(minutesBetweenDates) minuto"
                    } else {
                        dateText = "hace \(minutesBetweenDates) minutos"
                    }
                }
            } else  {
                if daysBetweenDates <= 1 {
                    dateText = "hace \(daysBetweenDates) día"
                } else {
                    dateText = "hace \(daysBetweenDates) días"
                }
            }
            
            return dateText
        }
        return ""
    }

}
