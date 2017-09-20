//
//  InstagramItem.swift
//  insights-for-instagram
//
//  Created by Alex Di Mango on 02/09/2017.
//  Copyright © 2017 Alex Di Mango. All rights reserved.
//

import RealmSwift
import ObjectMapper
import UIKit

class InstagramMedia: Object,Mappable {
    
    @objc dynamic var id = ""
    @objc dynamic var code = ""
    @objc dynamic var imageUrl = ""
    @objc dynamic var createdTime = Date()
    @objc dynamic var weekday = 0 // https://developer.apple.com/documentation/foundation/nsdatecomponents/1410442-weekday
    @objc dynamic var likesCount = 0
    @objc dynamic var commentsCount = 0
    @objc dynamic var engagementCount = 0 // includes the total number of Instagram accounts that liked or commented a post
    @objc dynamic var type = ""
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        code <- map["code"]
        imageUrl <- map["images.standard_resolution.url"]
        createdTime <- (map["created_time"], DateTransform())
        weekday = Calendar.current.component(.weekday, from: createdTime)
        likesCount <- map["likes.count"]
        commentsCount <- map["comments.count"]
        engagementCount = likesCount + commentsCount
        type <- map["type"]
    }
}
