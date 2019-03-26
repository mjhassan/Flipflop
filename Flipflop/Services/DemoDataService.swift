//
//  DemoDataService.swift
//  Flipflop
//
//  Created by Jahid Hassan on 3/26/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import Foundation

// mimicing service data
final class DemoDataService: ServiceProtocol {
    static let shared = DemoDataService()
    
    func fetchPosts(_ completion: @escaping ((Result<[Post], F2Error>) -> Void)) {
        guard let url = Bundle.main.url(forResource: "sample", withExtension: "json") else {
            completion(Result.failure(F2Error.invalidURL("sample.json")))
            return
        }
        
        guard let data = try? Data(contentsOf: url, options: .mappedIfSafe) else {
            completion(Result.failure(F2Error.dataNotFound))
            return
        }
        
        DataParser.parse(data: data, completion: completion)
    }
}
