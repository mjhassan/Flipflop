//
//  HomeViewModel.swift
//  Flipflop
//
//  Created by Jahid Hassan on 3/26/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import Foundation

class HomeViewModel {
    weak var service: ServiceProtocol?
    var onDataUpdate: ((Error?) -> Void)?
    var onIndexUpdate: ((Post) -> Void)?
    
    public private(set) var posts: [Post] = [Post]()
    public var currentIndex: Int = 0 {
        didSet {
            guard currentIndex >= 0 && currentIndex < posts.count else { return }
            
            onIndexUpdate?(posts[currentIndex])
        }
    }
    
    public var getCurrentPost: Post? {
        guard currentIndex >= 0 && currentIndex < posts.count else { return nil }
        
        return posts[currentIndex]
    }
    
    init(service: ServiceProtocol = DemoDataService.shared) {
        self.service = service
    }
    
    func fetchVideoPosts() {
        guard let service = service else {
            onDataUpdate?(F2Error.missingService)
            return
        }
        
        service.fetchPosts { [weak self] result in
            DispatchQueue.main.async {
                let err: Error?
                
                switch result {
                case .success(let posts) :
                    self?.posts = posts
                    err = nil
                case .failure(let error) :
                    err = error
                }
                
                self?.onDataUpdate?(err)
            }
        }
    }
    
    func getPost(`for` index: Int) -> Post {
        return posts[index]
    }
}
