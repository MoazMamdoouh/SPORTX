//
//  NetworkManager.swift
//  SPORTX
//
//  Created by moaz mamdouh on 21/05/2025.
//

import Foundation
import Foundation
import Network

import Foundation
import Network

class ReachabilityManager {
    static let shared = ReachabilityManager()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    private(set) var isConnected: Bool = false
    private var forceOffline: Bool = false
    
    private init() {
        monitor.pathUpdateHandler = { path in
            if self.forceOffline {
                self.isConnected = false
            } else {
                self.isConnected = path.status == .satisfied
            }
            print("Network Status Changed: \(self.isConnected ? "Connected" : "Disconnected")")
        }
        monitor.start(queue: queue)
    }

    static func isReachable() -> Bool {
        return shared.isConnected
    }

    static func simulateOffline(_ value: Bool) {
        shared.forceOffline = value
        shared.monitor.pathUpdateHandler?(shared.monitor.currentPath)
    }
}

