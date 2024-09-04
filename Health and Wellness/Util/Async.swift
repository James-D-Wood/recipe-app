//
//  Async.swift
//  Health and Wellness
//
//  Created by James Wood on 8/18/24.
//

import Foundation
import SwiftUI


// nothing in this file has a happy home yet :(

enum LoadingState {
    case idle
    case loading
    case failed(String)
    case loaded
}


// HTTP Client Implementation
// this is experiemental on my part - definitely would be better libraries out there

enum HTTPClientError: Error {
    case NotImplemented
}

enum HTTPMethod {
    case GET
    case PATCH
    case POST
    case PUT
    case DELETE
}

struct HTTPHeader {
    let header: String
    let value: String
}

struct HTTPRequest {
    let method: HTTPMethod
    let url: URL
    let headers: [HTTPHeader]?
    let body: Data?
}

struct HTTPResponse {
    let body: Data?
}

struct HTTPClient {
    func send(request: HTTPRequest) async throws -> HTTPResponse {
        switch request.method {
        case .GET:
            return try await get(url: request.url)
        default:
            throw HTTPClientError.NotImplemented
        }
    }
    
    func get(url: URL) async throws -> HTTPResponse {
        let (data, _) = try await URLSession.shared.data(from: url)
        return HTTPResponse(body: data)
    }
}

