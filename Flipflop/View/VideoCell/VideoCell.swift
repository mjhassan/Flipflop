//
//  VideoCell.swift
//  Flipflop
//
//  Created by Jahid Hassan on 3/26/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import UIKit
import ASPVideoPlayer

class VideoCell: UICollectionViewCell {
    @IBOutlet weak var playerView: ASPVideoPlayerView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addObserver()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addObserver()
    }
    
    public var videoUrl: URL! {
        didSet {
            playerView.videoURL = videoUrl
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configPlayer()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(clearPlayer),
                                               name: HomeWillDisappear,
                                               object: nil)
    }
    
    private func configPlayer() {
        playerView.shouldLoop = true
        playerView.startPlayingWhenReady = true
        playerView.gravity = .aspectFill
    }
    
    @objc private func clearPlayer() {
        playerView.startPlayingWhenReady = false
        playerView.stopVideo()
        playerView.videoURL = nil
    }
}
