//
//  File.swift
//  
//
//  Created by Justin Allen on 1/26/24.
//

import Foundation
import Network

public class NetworkService {
    public init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    let baseUrl: String
//    var baseUrl: String  {
//        return Config.getUnauthenticatedUrl(env:  SettingsStore().environment)
//    } // "http://192.168.10.248:3000"
    
    public func GET<T: Codable>(url endpoint: String, token: String?) async -> Result<T, Error> {
        guard let url = URL(string: "\(baseUrl)/\(endpoint)") else {
            // TODO: swap this to the Error case.
            return .failure(NetworkError.invalidURL)
        }
        do {
            var request = URLRequest(url: url)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.httpMethod = "GET"
            if let token {
                request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            let str = String(decoding: data, as: UTF8.self)
            print(str)
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200..<300:
                    let result = try JSONDecoder.network.decode(T.self, from: data)
                    return .success(result)
                case 401:
                    return .failure(NetworkError.unauthenticated)
                default:
                    // Here, you can handle different error cases based on status codes.
                    // You might want to decode the error response from the server and create a custom error.
                    // For now, I'll return a generic HTTPError with the status code.
                    return .failure(HTTPError(statusCode: httpResponse.statusCode))
                }
            }
            
            return .failure(NetworkError.unknown)
        } catch {
            print(error)
            return .failure(error)
        }
    }
    
    public func POST<Q: Codable, R: Codable>(url endpoint: String, token: String?, content: Q?) async -> Result<R, Error> {
        guard let url = URL(string: "\(baseUrl)/\(endpoint)") else {
            // TODO: swap this to the Error case.
            return .failure(NetworkError.invalidURL)
        }
        do {
            var request = URLRequest(url: url)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.httpMethod = "POST"
            if let token {
                request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            if let content {
                let data = try JSONEncoder.network.encode(content)
                request.httpBody = data
            }
            
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            let str = String(decoding: data, as: UTF8.self)
            print(str)
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200..<300:
                    let result = try JSONDecoder.network.decode(R.self, from: data)
                    return .success(result)
                case 401:
                    return .failure(NetworkError.unauthenticated)
                default:
                    // Here, you can handle different error cases based on status codes.
                    // You might want to decode the error response from the server and create a custom error.
                    // For now, I'll return a generic HTTPError with the status code.
                    return .failure(HTTPError(statusCode: httpResponse.statusCode))
                }
            }
            
            return .failure(NetworkError.unknown)
        } catch {
            print(error)
            return .failure(error)
        }
    }
    
    public func PUT<Q: Codable, R: Codable>(url endpoint: String, token: String?, content: Q?) async -> Result<R, Error> {
        guard let url = URL(string: "\(baseUrl)/\(endpoint)") else {
            // TODO: swap this to the Error case.
            return .failure(NetworkError.invalidURL)
        }
        do {
            var request = URLRequest(url: url)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.httpMethod = "PUT"
            if let token {
                request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            if let content {
                let data = try JSONEncoder.network.encode(content)
                request.httpBody = data
            }
            
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            let str = String(decoding: data, as: UTF8.self)
            print(str)
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200..<300:
                    let result = try JSONDecoder.network.decode(R.self, from: data)
                    return .success(result)
                case 401:
                    return .failure(NetworkError.unauthenticated)
                default:
                    // Here, you can handle different error cases based on status codes.
                    // You might want to decode the error response from the server and create a custom error.
                    // For now, I'll return a generic HTTPError with the status code.
                    return .failure(HTTPError(statusCode: httpResponse.statusCode))
                }
            }
            
            return .failure(NetworkError.unknown)
        } catch {
            print(error)
            return .failure(error)
        }
    }
    
}

public struct EmptyRequest: Codable {
    public init() {}
}
public struct EmptyResponse: Codable {
    public init() {}
}
