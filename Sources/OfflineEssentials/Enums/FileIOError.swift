//
//  File.swift
//  
//
//  Created by Justin Allen on 1/26/24.
//

import Foundation

public enum FileIOError: Error {
    case invalidPath
    case unknown
    case decodingError
    case fileNotFound
}
