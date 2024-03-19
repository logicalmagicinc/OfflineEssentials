//
//  File.swift
//  
//
//  Created by Justin Allen on 1/26/24.
//

import Foundation


public struct HTTPError: Error {
    public init(statusCode: Int) {
        self.statusCode = statusCode
    }
    let statusCode: Int
}


public enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidEmail
    case invalidPassword
    case unknown
    case responseParse
    case unauthenticated

    case withMessage(String)
    // Throw in all other cases
    case unexpected(code: Int)
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString(
                "The provided url is not valid.",
                comment: "Invalid URL"
            )
        case .invalidEmail:
            return NSLocalizedString(
                "The provided email is not valid.",
                comment: "Invalid Email"
            )
            
        case .invalidPassword:
            return NSLocalizedString(
                "The provided password is not valid.",
                comment: "Invalid Password"
            )
            
        case .responseParse:
            return NSLocalizedString(
                "Unable to parse the response.",
                comment: "Unparsable Response"
            )
//        case .notFound:
//            return NSLocalizedString(
//                "The specified item could not be found.",
//                comment: "Resource Not Found"
//            )
//
        case .unknown:
            return NSLocalizedString(
                "An Unknown Error Occured.",
                comment: "Unknown Error"
            )
            
        case .unauthenticated:
            return NSLocalizedString("Unauthenticated", comment: "Unauthenticated")
        case .unexpected(_):
            return NSLocalizedString(
                "An unexpected error occurred.",
                comment: "Unexpected Error"
            )
        case .withMessage(let message):
            return NSLocalizedString(
                message,
                comment: "Error Occurred"
            )
        }
    }
}
