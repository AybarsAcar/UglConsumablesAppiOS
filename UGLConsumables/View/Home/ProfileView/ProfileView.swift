//
//  ProfileView.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 28/1/2022.
//

import SwiftUI


struct ProfileView: View {
  
  @Environment(\.presentationMode) private var presentationMode
  @AppStorage("isLightTheme") private var isLightTheme: Bool = true
  
  
  @StateObject private var viewModel = ProfileViewModel()
  @State private var isSettigsDiplayed: Bool = false
  
  
  var body: some View {
    Text("Hello, World!")
      .navigationTitle("Profile")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: {
            isSettigsDiplayed.toggle()
          }) {
            Image(systemName: "gear")
              .foregroundColor(.primary)
          }
        }
      }
      .sheet(isPresented: $isSettigsDiplayed) {
        settingsSheet
          .padding()
      }
  }
}


extension ProfileView {
  
  private var settingsSheet: some View {
    VStack {
      
      Toggle("Theme", isOn: $isLightTheme)
      
      Button(action: {
        isSettigsDiplayed = false
        viewModel.logout()
      }) {
        Text("LOGOUT")
          .blockCapsuleButtonStyle()
      }
    }
  }
}


struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}
