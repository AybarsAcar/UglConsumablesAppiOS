//
//  CreateView.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 28/1/2022.
//

import SwiftUI

struct CreateView: View {
  
  @Environment(\.presentationMode) private var presentationMode
  
  @StateObject private var viewModel = CreateUpdateConsumableViewModel()
  
  @State private var showCamera: Bool = false
  @State private var photo: UIImage? = nil
  @State private var selection: Int = 0
  
  
  var body: some View {
    NavigationView {
      ScrollView {
        VStack {
          imageView
            .padding(40)
            .fullScreenCover(isPresented: $showCamera) {
              CameraView()
            }
          
          UnderlinedTextField(text: $viewModel.sapId, activeIcon: "doc.text.image.fill", defaultIcon: "doc.text.image", placeholder: "Sap Id")
            .keyboardType(.numberPad)
          
          UnderlinedTextField(text: $viewModel.description, activeIcon: "doc.text.image.fill", defaultIcon: "doc.text.image", placeholder: "Description")
          
          DropdownPicker(title: "Unit of Measure", selection: $selection, options: Consumable.UnitOfMeasure.allCases.map({ $0.rawValue }))
          
          Toggle("PRD", isOn: $viewModel.isPrd)
          
          // LIST SERVICE ORDERS HERE
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
      
      if let photo = photo {
        Image(uiImage: photo)
          .scaledToFit()
          .frame(width: 300, height: 400)
      }
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
