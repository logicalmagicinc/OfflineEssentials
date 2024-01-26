//
//  Date+extennsion.swift
//  LifeManager
//
//  Created by Justin Allen on 1/26/24.
//

import Foundation


extension Date {
    var dispatchTime: DispatchTime {
        let now = Date()
        let interval = self.timeIntervalSince(now)
        return DispatchTime.now() + interval
    }
}

