//
//  Enums.swift
//  Flipflop
//
//  Created by Jahid Hassan on 3/26/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import Foundation

// Errors
enum F2Error: Error {
    case invalidURL(String)
    case dataNotFound
    case missingService
    case dataDecodeFail
}

extension F2Error: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL(let url):
            return NSLocalizedString("Invalid url", comment: "\(url)")
        case .dataNotFound:
            return NSLocalizedString("Data not found", comment: "")
        case .missingService:
            return NSLocalizedString("Service is missing", comment: "")
        case .dataDecodeFail:
            return NSLocalizedString("Failed to decode data", comment: "")
        }
    }
}

// service responses
enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}

// cell ids
enum Identifier: String {
    case videoCell = "VideoCell"
}

// notifications
public let HomeWillDisappear = Notification.Name("HomeWillDisappear")
