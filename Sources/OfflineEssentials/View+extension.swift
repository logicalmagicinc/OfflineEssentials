//
//  View+extension.swift
//  LifeManager
//
//  Created by Justin Allen on 1/26/24.
//

import Foundation
import SwiftUI

extension View {
    func onReceive(
        _ name: Notification.Name,
        center: NotificationCenter = .default,
        object: AnyObject? = nil,
        perform action: @escaping (Notification) -> Void
    ) -> some View {
        onReceive(
            center.publisher(for: name, object: object),
            perform: action
        )
    }
}
