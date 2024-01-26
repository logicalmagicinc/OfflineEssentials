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
    
    // APP Specific Stuff
//    @Published var authenticatedUser: User?
//    @Published var adminUser: User?
    
//    @Published var messages: [Message]?
//    @Published var teamMembers: [User]?
    
    
    // System Stuff
    
    
//    @Published private var
//    public func registerSource () {
//        
//    }
    
    
//    private var token: String? {
//        QuickStorage.shared.string(forKey: .accessToken)
//    }
    
    
//    @objc func notificationReceived(_ notification: Notification) {
//        // Handle the notification
//        print("Notification received!")
//        Task {
//            await self.reloadData()
//        }
//    }
    
//    @objc func logoutNotification(_ notification: Notification) {
//        // Handle the notification
//        authenticatedUser = nil
//    }
     
    public init () {
        
//        self.baseUrl = baseUrl
        
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
        
//        NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived(_:)), name: .Chat, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(logoutNotification(_:)), name: .ActiveViewChanged_Unauthenticated, object: nil)
        
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
            Task {
                await loadFromNetwork()
            }
        }
        else {
            Task {
                await loadFromFiles()
            }
        }
        
        // in post this would reload the user, then also the surveys main list, and the survey questions files. but not the survey answer files.
    }
    
    
    
    // Expecting to be overwritten
    open func loadFromFiles() async {
        
//        if case let .success(success) = (await FileService.READ(url: "user.json") as Result<User, Error>) {
//            DispatchQueue.main.async {
//                print("Load user from offline storage")
//                self.authenticatedUser = success
//            }
//        }
//        
//        if case let .success(success) = (await FileService.READ(url: "messages.json") as Result<[Message], Error>) {
//            DispatchQueue.main.async {
//                print("Load messages from offline storage")
//                self.messages = success
//            }
//        }
//        
//        if case let .success(success) = (await FileService.READ(url: "teamMembers.json") as Result<[User], Error>) {
//            DispatchQueue.main.async {
//                print("Load messages from offline storage")
//                self.teamMembers = success
//            }
//        }
        
    }
    
    // Expecting to be overwritten
    open func loadFromNetwork() async {
        // Load the user!
//        if case let .success(success) = (await NetworkService(baseUrl: baseUrl).GET(url: "api/me", token: token) as Result<User, Error>) {
//            DispatchQueue.main.async {
//                self.authenticatedUser = success
//                Task {
//                    await FileService.WRITE(url: "user.json", content: success)
//                }
//            }
//        }
//        
//        if case let .success(success) = (await NetworkService(baseUrl: baseUrl).GET(url: "api/message", token: token) as Result<[Message], Error>) {
//            DispatchQueue.main.async {
//                self.messages = success
//                Task {
//                    await FileService.WRITE(url: "messages.json", content: success)
//                }
//            }
//        }
//        
//        struct TeamWrapper: Codable {
//            var team: Team
//            var members: [User]
//        }
//        if case let .success(success) = (await NetworkService(baseUrl: baseUrl).GET(url: "api/team", token: token) as Result<TeamWrapper, Error>) {
//            DispatchQueue.main.async {
//                self.teamMembers = success.members
//                print(success)
////                print("Team \(self.team?.members?.count)")
//                Task {
//                    await FileService.WRITE(url: "teamMembers.json", content: success.members)
//                }
//            }
//        }
    }
    
}



/*
 
 class DataStore: DataStoreBase {
     override init(baseUrl: String) {
         super.init(baseUrl: baseUrl)
     }
     
     //    // Expecting to be overwritten
     public override func loadFromFiles() async {

         if case let .success(success) = (await FileService.READ(url: "user.json") as Result<User, Error>) {
             DispatchQueue.main.async {
                 print("Load user from offline storage")
                 self.authenticatedUser = success
             }
         }

         if case let .success(success) = (await FileService.READ(url: "messages.json") as Result<[Message], Error>) {
             DispatchQueue.main.async {
                 print("Load messages from offline storage")
                 self.messages = success
             }
         }

         if case let .success(success) = (await FileService.READ(url: "teamMembers.json") as Result<[User], Error>) {
             DispatchQueue.main.async {
                 print("Load messages from offline storage")
                 self.teamMembers = success
             }
         }

     }
     //
     //    // Expecting to be overwritten
     public override func loadFromNetwork() async {
         // Load the user!
         if case let .success(success) = (await NetworkService(baseUrl: baseUrl).GET(url: "api/me", token: token) as Result<User, Error>) {
             DispatchQueue.main.async {
                 self.authenticatedUser = success
                 Task {
                     await FileService.WRITE(url: "user.json", content: success)
                 }
             }
         }

         if case let .success(success) = (await NetworkService(baseUrl: baseUrl).GET(url: "api/message", token: token) as Result<[Message], Error>) {
             DispatchQueue.main.async {
                 self.messages = success
                 Task {
                     await FileService.WRITE(url: "messages.json", content: success)
                 }
             }
         }

         struct TeamWrapper: Codable {
             var team: Team
             var members: [User]
         }
         if case let .success(success) = (await NetworkService(baseUrl: baseUrl).GET(url: "api/team", token: token) as Result<TeamWrapper, Error>) {
             DispatchQueue.main.async {
                 self.teamMembers = success.members
                 print(success)
 //                print("Team \(self.team?.members?.count)")
                 Task {
                     await FileService.WRITE(url: "teamMembers.json", content: success.members)
                 }
             }
         }
     }
     
 }
 
 
 */




/*
 
 class DataStore: DataStoreBase {
     override init(baseUrl: String) {
         super.init(baseUrl: baseUrl)
         
         NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived(_:)), name: .Chat, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(logoutNotification(_:)), name: .ActiveViewChanged_Unauthenticated, object: nil)
     }
     
     private var token: String? {
         QuickStorage.shared.string(forKey: .accessToken)
     }
     
     //        NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived(_:)), name: .Chat, object: nil)
     //        NotificationCenter.default.addObserver(self, selector: #selector(logoutNotification(_:)), name: .ActiveViewChanged_Unauthenticated, object: nil)
     
     //        NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived(_:)), name: .Chat, object: nil)
     //        NotificationCenter.default.addObserver(self, selector: #selector(logoutNotification(_:)), name: .ActiveViewChanged_Unauthenticated, object: nil)
     
     @objc func notificationReceived(_ notification: Notification) {
         // Handle the notification
         print("Notification received!")
         Task {
             await self.reloadData()
         }
     }
     
     @objc func logoutNotification(_ notification: Notification) {
         // Handle the notification
         authenticatedUser = nil
     }
     
     //    // Expecting to be overwritten
     public override func loadFromFiles() async {

         if case let .success(success) = (await FileService.READ(url: "user.json") as Result<User, Error>) {
             DispatchQueue.main.async {
                 print("Load user from offline storage")
                 self.authenticatedUser = success
             }
         }

         if case let .success(success) = (await FileService.READ(url: "messages.json") as Result<[Message], Error>) {
             DispatchQueue.main.async {
                 print("Load messages from offline storage")
                 self.messages = success
             }
         }

         if case let .success(success) = (await FileService.READ(url: "teamMembers.json") as Result<[User], Error>) {
             DispatchQueue.main.async {
                 print("Load messages from offline storage")
                 self.teamMembers = success
             }
         }

     }
     //
     //    // Expecting to be overwritten
     public override func loadFromNetwork() async {
         // Load the user!
         if case let .success(success) = (await NetworkService(baseUrl: baseUrl).GET(url: "api/me", token: token) as Result<User, Error>) {
             DispatchQueue.main.async {
                 self.authenticatedUser = success
                 Task {
                     await FileService.WRITE(url: "user.json", content: success)
                 }
             }
         }

         if case let .success(success) = (await NetworkService(baseUrl: baseUrl).GET(url: "api/message", token: token) as Result<[Message], Error>) {
             DispatchQueue.main.async {
                 self.messages = success
                 Task {
                     await FileService.WRITE(url: "messages.json", content: success)
                 }
             }
         }

         struct TeamWrapper: Codable {
             var team: Team
             var members: [User]
         }
         if case let .success(success) = (await NetworkService(baseUrl: baseUrl).GET(url: "api/team", token: token) as Result<TeamWrapper, Error>) {
             DispatchQueue.main.async {
                 self.teamMembers = success.members
                 print(success)
 //                print("Team \(self.team?.members?.count)")
                 Task {
                     await FileService.WRITE(url: "teamMembers.json", content: success.members)
                 }
             }
         }
     }
     
 }

 
 
 
 
 
 
 */
