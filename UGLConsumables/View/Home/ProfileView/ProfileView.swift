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
  
  @State private var showHalfModal = false
  
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
      
      ToolbarItem(placement: .navigationBarLeading) {
        Text("Display")
          .onTapGesture {
            showHalfModal.toggle()
          }
      }
    }
    .sheet(isPresented: $isSettigsDiplayed) {
      SettingsView(viewModel: viewModel)
        .padding()
    }
    .halfSheet(isPresented: $showHalfModal) {
      ZStack {
        
        Text("Hello from half modal!")
          .font(.system(size: 24, weight: .semibold, design: .serif))
          .foregroundColor(.primary)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(.ultraThinMaterial)
    }
  }
}



struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ProfileView()
    }
  }
}
