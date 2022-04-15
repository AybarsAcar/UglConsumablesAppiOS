//
//  NetworkMonitor.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 15/4/2022.
//

import Foundation
import Network

/// Singleton Wrapper Manager class over NWPathMonitor
final class NetworkMonitor: ObservableObject {
  static let shared = NetworkMonitor()
  
  @Published private(set) var connectionStatus: NWPath.Status = .satisfied
  
  private let monitor: NWPathMonitor
  private let queue = DispatchQueue(label: "NetworkMonitorQueue")
  
  private init() {
    self.monitor = NWPathMonitor()
  }
  
  /// starts monitoring network connection of the device
  func start() {
    // run the monitor
    monitor.start(queue: queue)
    
    // called each time the connectivity status updates
    monitor.pathUpdateHandler = { [weak self] path in
      self?.connectionStatus = path.status
    }
  }
  
  /// stops monitoring network connection of the device
  func stop() {
    monitor.cancel()
  }
}
