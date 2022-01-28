//
//  UGLConsumablesApp.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 22/1/2022.
//

import SwiftUI

@main
struct UGLConsumablesApp: App {
  
  @AppStorage("isLightTheme") private var isLightTheme: Bool = true
  @AppStorage("token") private var token: String = ""
  @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
  
  var body: some Scene {
    WindowGroup {
      ZStack {
        if !isLoggedIn {
          LoginRegisterScreen()
            .transition(.move(edge: .bottom))
            .preferredColorScheme(isLightTheme ? .light : .dark)
        } else {
          HomeScreen()
            .transition(.move(edge: .bottom))
            .preferredColorScheme(isLightTheme ? .light : .dark)
        }
      }
    }
  }
}
