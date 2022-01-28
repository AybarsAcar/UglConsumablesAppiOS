//
//  SettingsView.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 28/1/2022.
//

import SwiftUI

struct SettingsView: View {
  
  @Environment(\.presentationMode) private var presentationMode
  @AppStorage("isLightTheme") private var isLightTheme: Bool = true
  
  @StateObject var viewModel: ProfileViewModel
  
  init(viewModel: ProfileViewModel) {
    self._viewModel = StateObject.init(wrappedValue: viewModel)
  }
  
  var body: some View {
    VStack {
      
      Toggle("Theme", isOn: $isLightTheme)
      
      Button(action: {
        presentationMode.wrappedValue.dismiss()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
          viewModel.logout()
        }
      }) {
        Text("LOGOUT")
          .blockCapsuleButtonStyle()
      }
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView(viewModel: ProfileViewModel())
  }
}
