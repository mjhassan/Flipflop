//
//  DataParser.swift
//  Flipflop
//
//  Created by Jahid Hassan on 3/26/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import Foundation

final class DataParser {
    static func parse(data: Data, completion: ((Result<[Post], F2Error>) -> Void)) {
        guard let posts = try? JSONDecoder().decode([Post].self, from: data) else {
            completion(Result.failure(F2Error.dataDecodeFail))
            return
        }
        
        completion(Result.success(posts))
    }
}
