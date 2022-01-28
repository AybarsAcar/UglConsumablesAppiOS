//
//  ProfileView.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 28/1/2022.
//

import SwiftUI


struct ProfileView: View {
  
  @StateObject private var viewModel = ProfileViewModel()
  @State private var isSettigsDiplayed: Bool = false
  
  
  var body: some View {
    VStack{
      Text("Hello, World!")
    }
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
      SettingsView(viewModel: viewModel)
        .padding()
    }
  }
}



struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}
