//
//  OrderView.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 3/2/2022.
//

import SwiftUI


struct OrderView: View {
  
  @State private var showCreateOrder: Bool = false
  
  var body: some View {
    ScrollView {
      Text("Hello, World!")
        .fullScreenCover(isPresented: $showCreateOrder) {
          NewOrderView()
        }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .navigationTitle("Orders")
    .overlay(alignment: .bottomTrailing) {
      Button(action: {
        showCreateOrder.toggle()
      }) {
        Image(systemName: "paperplane.fill")
          .foregroundColor(.white)
          .font(.title)
          .padding(20)
          .background(.orange)
          .cornerRadius(100)
          .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 10)
      }
      .padding(.trailing, 20)
      .padding(.bottom, 75)
    }
  }
}



struct OrderView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      OrderView()
    }
  }
}
