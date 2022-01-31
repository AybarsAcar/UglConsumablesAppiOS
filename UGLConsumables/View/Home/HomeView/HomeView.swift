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
    List {
      Section(header: Text("Consumables Work Areas")) {
        ForEach(viewModel.areaOfWorkDtos) { item in
          NavigationLink(destination: Text(item.description)) {
            listItem(item: item)
          }
          .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button {
              //
            } label: {
              Label("Mute", systemImage: "bell.slash.fill")
            }
            .tint(.theme.green)
          }
          .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button {
              //
            } label: {
              Label("Mute", systemImage: "trash.fill")
            }
            .tint(.theme.red)
          }
        }
      }
    }
    .listStyle(.plain)
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
      if viewModel.areaOfWorkDtos.isEmpty {
        await viewModel.list()
      }
    }
  }
}


extension HomeView {
  private func listItem(item: AreaOfWorkDto) -> some View {
    HStack {
      Text(verbatim: "\(item.serviceOrder)")
      Spacer()
      Text(item.description)
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
