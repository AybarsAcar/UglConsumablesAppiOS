//
//  HomeView.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 28/1/2022.
//

import SwiftUI


struct HomeView: View {
  
  var body: some View {
    Text("Hello, World!")
      .navigationTitle("Home View")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: {
          }) {
            Image(systemName: "plus.circle")
              .foregroundColor(.primary)
          }
        }
      }
  }
}



struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      HomeView()
    }
  }
}
