//
//  WebServiceConstants.swift
//  TrycariOS
//
//  Created by Musthafa on 10/05/21.
//

import Foundation

enum AMHttpMethod : Int {
    case post
    case get
    case put
    
    func name() -> String {
        switch self {
        case .post:
            return "POST"
        case .get:
            return "GET"
        case .put:
            return "PUT"
        }
    }
}
struct WebServiceURLs {
    static let baseURL = "https://my-json-server.typicode.com/typicode/demo/"
    static let postsEngPoint = "posts"
    static let commentsEngPoint = "comments"
}

public enum WebServiceError: Error {
    case noInterNet
    case error_2

}

extension WebServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noInterNet:
            return NSLocalizedString("A user-friendly description of the error_1.", comment: "My error_1")
        case .error_2:
            return NSLocalizedString("A user-friendly description of the error_2.", comment: "My error_2")
        }
    }
}
