//
//  NewOrderView.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 3/2/2022.
//

import SwiftUI

struct NewOrderView: View {
  
  @Environment(\.presentationMode) private var presentationMode
  
  var body: some View {
    NavigationView {
      Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            Image(systemName: "xmark")
              .onTapGesture {
                presentationMode.wrappedValue.dismiss()
              }
          }
        }
    }
  }
}


struct NewOrderView_Previews: PreviewProvider {
  static var previews: some View {
    NewOrderView()
  }
}
