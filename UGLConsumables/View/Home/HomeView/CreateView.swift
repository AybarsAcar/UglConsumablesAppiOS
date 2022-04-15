//
//  CreateView.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 28/1/2022.
//

import SwiftUI

struct CreateView: View {
  
  @Environment(\.dismiss) private var dismiss
  
  @StateObject private var viewModel = CreateUpdateConsumableViewModel()
  
  @State private var showCamera = false
  @State private var showUserGallery = false
  @State private var photo: UIImage? = nil
  @State private var selection: Int = 0
  
  @Namespace private var selectedChip
  
  var body: some View {
    NavigationView {
      ScrollView {
        VStack(spacing: 20) {
          imageView
            .padding(40)
            .fullScreenCover(isPresented: $showCamera) {
              CameraView()
            }
          
          UnderlinedTextField(text: $viewModel.sapId, activeIcon: "doc.text.image.fill", defaultIcon: "doc.text.image", placeholder: "Sap Id")
            .keyboardType(.numberPad)
          
          UnderlinedTextField(text: $viewModel.description, activeIcon: "doc.text.image.fill", defaultIcon: "doc.text.image", placeholder: "Description")
          
          DropdownPicker(title: "Unit of Measure", selection: $selection, options: Consumable.UnitOfMeasure.allCases.map({ $0.rawValue }))
          
          HStack(spacing: 20) {
            Text("B01")
              .foregroundColor(viewModel.isPrd ? .primary : .white)
              .frame(height: 55)
              .frame(maxWidth: .infinity)
              .background(
                ZStack {
                  Color.clear
                  if !viewModel.isPrd {
                    RoundedRectangle(cornerRadius: 12)
                      .fill(Color.theme.blue)
                      .frame(height: 55)
                      .frame(maxWidth: .infinity)
                      .matchedGeometryEffect(id: "selectedChip", in: selectedChip)
                  }
                }
              )
              .onTapGesture {
                withAnimation {
                  viewModel.isPrd = false
                }
              }
            
            
            Text("PRD")
              .foregroundColor(viewModel.isPrd ? .white : .primary)
              .frame(height: 55)
              .frame(maxWidth: .infinity)
              .background(
                ZStack {
                  Color.clear
                  if viewModel.isPrd {
                    RoundedRectangle(cornerRadius: 12)
                      .fill(Color.theme.blue)
                      .frame(height: 55)
                      .frame(maxWidth: .infinity)
                      .matchedGeometryEffect(id: "selectedChip", in: selectedChip)
                  }
                }
              )
              .onTapGesture {
                withAnimation {
                  viewModel.isPrd = true
                }
              }
          }
          
          // LIST SERVICE ORDERS HERE - ADD to service order option
          
          Button(action: {}) {
            Text("Create".uppercased())
              .blockCapsuleButtonStyle()
          }
          .buttonStyle(.withPressableButtonStyle)
          
        }
        .padding(.horizontal)
      }
      .navigationBarTitle("Create a Product")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Image(systemName: "xmark")
            .onTapGesture {
              dismiss()
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
          .resizable()
          .scaledToFit()
          .frame(width: 300, height: 400)
      }
    }
    .frame(width: 300, height: 400)
    .overlay(alignment: .bottom) {
      HStack {
        Button(action: {
          // open user gallery
          showUserGallery.toggle()
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
    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
    .sheet(isPresented: $showUserGallery) {
      ImagePicker(image: $photo)
    }
  }
}

struct CreateView_Previews: PreviewProvider {
  static var previews: some View {
    CreateView()
  }
}
