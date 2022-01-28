//
//  HomeScreen.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 28/1/2022.
//

import SwiftUI


struct HomeScreen: View {
  
  @ObservedObject private var viewModel = HomeViewModel()
  
  var body: some View {
    VStack {
      Text("Home")
      
      Button {
        viewModel.logout()
      } label: {
        Text("Logout")
          .blockCapsuleButtonStyle(backgroundColor: .black, foregroundColor: .white)
      }
      .padding()

      
    }
    .navigationTitle("Home Screen")
  }
}



struct HomeScreen_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      HomeScreen()
    }
  }
}
