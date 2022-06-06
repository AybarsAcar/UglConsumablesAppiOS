//
//  ContentView.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 6/6/2022.
//

import SwiftUI

struct ContentView: View {
  
  @AppStorage("isLightTheme") private var isLightTheme: Bool = true
  @AppStorage("token") private var token: String = ""
  @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
  
  @EnvironmentObject var networkMonitor: NetworkMonitor
  
  var body: some View {
    ZStack(alignment: .bottom) {
      if !isLoggedIn {
        LoginRegisterScreen()
          .transition(.move(edge: .bottom))
          .preferredColorScheme(isLightTheme ? .light : .dark)
        
      } else {
        HomeScreen()
          .transition(.move(edge: .bottom))
          .preferredColorScheme(isLightTheme ? .light : .dark)
      }
      
      if networkMonitor.connectionStatus == .unsatisfied {
        SnackbarView(isDisplayed: .constant(true), message: "Not connected to internet", type: .error) {}
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(MainAppState())
      .environmentObject(NetworkMonitor.shared)
  }
}
