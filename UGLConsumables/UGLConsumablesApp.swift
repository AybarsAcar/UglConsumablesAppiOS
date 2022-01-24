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
  
  var body: some Scene {
    WindowGroup {
      LoginRegisterView()
        .preferredColorScheme(isLightTheme ? .light : .dark)
    }
  }
}
