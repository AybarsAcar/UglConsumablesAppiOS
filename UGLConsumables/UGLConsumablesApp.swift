//
//  UGLConsumablesApp.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 22/1/2022.
//

import SwiftUI

@main
struct UGLConsumablesApp: App {
  
  
  @StateObject private var appState = MainAppState()
  
  private let networkMonitor = NetworkMonitor.shared
  
  init() {
    networkMonitor.start()
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(appState)
        .environmentObject(networkMonitor)
    }
  }
}
