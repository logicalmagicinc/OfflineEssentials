//
//  JSONEncoder+extension.swift
//  LifeManager
//
//  Created by Justin Allen on 1/26/24.
//

import Foundation

extension JSONEncoder {
    public static var network: JSONEncoder {
        
        let encoder = JSONEncoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        encoder.outputFormatting = .prettyPrinted
        
        return encoder
    }
}
