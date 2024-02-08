//
//  File.swift
//  
//
//  Created by Justin Allen on 1/26/24.
//

import Foundation

public class FileService {
    public static func READ<T: Codable>(url endpoint: String) async -> Result<T, Error> {
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appending(path: endpoint)
            do {
                let jsonString = try String(contentsOf: fileURL, encoding: .utf8)
                let data = jsonString.data(using: .utf8)!
                let results = try JSONDecoder.network.decode(T.self, from: data)
                return .success(results)
            } catch {
                print("Error reading \(fileURL): \(error)")
            }
        }
        
        
        
        return Result.failure(FileIOError.unknown)
    }
    
    public static func WRITE<T: Codable>(url endpoint: String, content: T) async -> Result<T, Error> {
        
        // new
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return .failure(FileIOError.invalidPath)
        }
        
        let fileURL = dir.appendingPathComponent(endpoint) // Use appendingPathComponent for path construction
        
        // Create the directories leading up to the file if they do not exist
        let directoryURL = fileURL.deletingLastPathComponent() // Get the directory part of the fileURL
        do {
            try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error creating directory \(directoryURL): \(error)")
            return .failure(error) // Return failure if unable to create the directory
        }
        
        // end new
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appending(path: endpoint)
            do {
                let data = try JSONEncoder.network.encode(content)
                if let jsonString = String(data: data, encoding: .utf8) {
                    try jsonString.write(to: fileURL, atomically: false, encoding: .utf8)
                    return .success(content)
                }
            } catch {
                print("Error reading \(fileURL): \(error)")
            }
        }
        
        return Result.failure(FileIOError.unknown)
    }
}
