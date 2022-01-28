//
//  CreateView.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 28/1/2022.
//

import SwiftUI

struct CreateView: View {
  
  @Environment(\.presentationMode) private var presentationMode
  @State private var selection: Int = 0
  
  var body: some View {
    VStack{
      Text("Hello")
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .overlay(alignment: .topTrailing) {
      Image(systemName: "xmark")
        .onTapGesture {
          presentationMode.wrappedValue.dismiss()
        }
    }
    .padding()
  }
}

struct CreateView_Previews: PreviewProvider {
  static var previews: some View {
    CreateView()
  }
}
