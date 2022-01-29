//
//  HomeView.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 28/1/2022.
//

import SwiftUI


struct HomeView: View {
  
  @State private var showCreateView: Bool = false
  
  @StateObject private var viewModel = HomeViewModel()
  
  
  var body: some View {
    ScrollView{
      VStack{
        ForEach(viewModel.areaOfWorkDtos) { item in
          HStack {
            Text("Service Order: \(item.serviceOrder)")
            Spacer()
            Text(item.description)
          }
        }
      }
    }
    .overlay(alignment: .center, content: {
      if viewModel.isLoading {
        ProgressView()
      }
    })
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
    .task {
      await viewModel.list()
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
