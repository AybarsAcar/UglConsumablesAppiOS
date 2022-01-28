//
//  HomeView.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 28/1/2022.
//

import SwiftUI


struct HomeView: View {
  
  @State private var showCreateView: Bool = false
  
  var body: some View {
    ScrollView{
      VStack{
        Text("Hello, World!")
      }
    }
    .navigationTitle("Home View")
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: {
          showCreateView.toggle()
        }) {
          Image(systemName: "plus.circle")
            .foregroundColor(.primary)
        }
      }
    }
    .fullScreenCover(isPresented: $showCreateView) {
      CreateView()
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
