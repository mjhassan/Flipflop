//
//  Post.swift
//  Flipflop
//
//  Created by Jahid Hassan on 3/26/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import Foundation

struct Post: Decodable {
    let title: String
    let url: URL
    let streamer: String?
    let game: String?
    let postedTime: String
    let points: String
    
    enum CodingKeys : String, CodingKey {
        case title, streamer, game, points
        case url = "video_link"
        case postedTime = "posted_time"
    }
}
