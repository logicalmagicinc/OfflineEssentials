//
//  File.swift
//  
//
//  Created by Justin Allen on 1/26/24.
//

import Foundation
import Network

open class DataStoreBase: ObservableObject, Observable {
    
    // Messages in queue to send when online. This would also be useful for sending surveys for post.
    
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
//    @Published public var baseUrl: String = ""
//    @Published public var token: String? = nil
    
    // Could store all the app data in a dictionary. and give a typed way to set and recieve it?
    // could add a way to register the types and endpoints and offline file name.
    
    @Published public var isOnline: Bool = false
    @Published public var dataSource: Dictionary<String, Any?> = Dictionary()
    
//    @Published public var storage: Dictionary<Any.Type, [String]>

    public init () {
        networkMonitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isOnline = path.status == .satisfied
                if self.isOnline {
                    Task {
                        await self.reloadData() // reloads after coming back online?!
                        // this would also be used to send requests.
                    }
                }
                
            }
        }
        
        networkMonitor.start(queue: workerQueue)
        Task {
            await reloadData()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // use an enum set to determine which Items get updates, .all could be used for initial load and .chat could be from the notification.  so we don't load more then neede.
    public func reloadData() async {
        
        print("---------------- reload data called --------------")
        
        if isOnline {
//            Task {
                await loadFromNetwork()
//            }
        }
        else {
//            Task {
                await loadFromFiles()
//            }
        }
        
        // in post this would reload the user, then also the surveys main list, and the survey questions files. but not the survey answer files.
    }
    
    
    
    // Expecting to be overwritten
    open func loadFromFiles() async {
                
    }
    
    // Expecting to be overwritten
    open func loadFromNetwork() async {

    }
    
}


