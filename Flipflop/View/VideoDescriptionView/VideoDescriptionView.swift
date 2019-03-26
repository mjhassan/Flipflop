//
//  VideoDescriptionView.swift
//  Flipflop
//
//  Created by Jahid Hassan on 3/26/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import UIKit

class VideoDescriptionView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var uploaderAndGameLabel: UILabel!
    @IBOutlet weak var postedTimeLabel: UILabel!
    
    public var post: Post? = nil {
        didSet {
            guard let post = post else {
                titleLabel.text = ""
                uploaderAndGameLabel.text = ""
                postedTimeLabel.text = ""
                
                return
            }
            
            titleLabel.text = post.title
            uploaderAndGameLabel.text = "\(post.streamer ?? "A streamer") playing \(post.game ?? "uknown")"
            postedTimeLabel.text = "↑ \(post.points)\t⏱ \(post.postedTime)"
        }
    }
}
