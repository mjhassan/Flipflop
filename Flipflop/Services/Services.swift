//
//  Services.swift
//  Flipflop
//
//  Created by Jahid Hassan on 3/26/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import Foundation

protocol ServiceProtocol: class {
    func fetchPosts(_ completion: @escaping ((Result<[Post], F2Error>) -> Void))
}

final class Services: ServiceProtocol {
    static let shared = Services()
    
    func fetchPosts(_ completion: @escaping ((Result<[Post], F2Error>) -> Void)) {
        // need actual service implementation
    }
}
