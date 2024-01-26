//
//  JSONDecoder+extension.swift
//  LifeManager
//
//  Created by Justin Allen on 1/26/24.
//

import Foundation

extension JSONDecoder {
    public static var network: JSONDecoder {
        
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return decoder
    }
}
