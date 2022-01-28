//
//  CreateView.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 28/1/2022.
//

import SwiftUI

struct CreateView: View {
  
  @Environment(\.presentationMode) private var presentationMode
  @State private var showCamera: Bool = false
  
  @State private var name: String = ""
  
  var body: some View {
    NavigationView {
      ScrollView {
        VStack{
          imageView
            .padding(40)
            .fullScreenCover(isPresented: $showCamera) {
              CameraView()
            }
          
          UnderlinedTextField(text: $name, activeIcon: "doc.text.image.fill", defaultIcon: "doc.text.image", placeholder: "Name")
        }
        .padding(.horizontal)
      }
      .navigationBarTitle("Create a Product")
      .navigationBarTitleDisplayMode(.inline)
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


extension CreateView {
  
  private var imageView: some View {
    
    ZStack {
      
      Color.gray.opacity(0.4)
      
      Image("")
        .scaledToFit()
        .frame(width: 300, height: 400)
    }
    .frame(width: 300, height: 400)
    .overlay(alignment: .bottom) {
      HStack {
        Button(action: {
          // open user gallery
        }) {
          Image(systemName: "photo")
            .foregroundColor(.white)
        }
        .padding()
        
        Spacer()
        
        Button(action: {
          showCamera.toggle()
        }) {
          Image(systemName: "camera.fill")
            .foregroundColor(.white)
        }
        .padding()
      }
    }
  }
}


struct CreateView_Previews: PreviewProvider {
  static var previews: some View {
    CreateView()
  }
}
