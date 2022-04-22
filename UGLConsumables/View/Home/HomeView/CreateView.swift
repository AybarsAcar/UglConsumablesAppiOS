//
//  CreateView.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 28/1/2022.
//

import SwiftUI

struct CreateView: View {
  
  @Environment(\.dismiss) private var dismiss
  
  @StateObject private var consumableVM = CreateUpdateConsumableViewModel()
  @StateObject private var areaOfWorkVM = CreateUpdateAreaOfWorkViewModel()
  
  @State private var showCreateProductView = true
  
  @State private var showCamera = false
  @State private var showUserGallery = false
  @State private var photo: UIImage? = nil
  @State private var selection: Int = 0
  
  @Namespace private var selectedChip
  
  var body: some View {
    VStack {
      headerView
      
      ZStack {
        if showCreateProductView {
          createProductView
            .transition(.move(edge: .leading))
        }
        
        if !showCreateProductView {
          createAreaOfWorkView
            .transition(.move(edge: .trailing))
        }
        
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
  }
}


extension CreateView {
  
  private var headerView: some View {
    ZStack {
      HStack {
        Button {
          dismiss()
        } label: {
          Image(systemName: "xmark")
            .font(.system(size: 24, weight: .regular))
            .foregroundColor(.primary)
        }
        
        Spacer()
      }
      
      Text(showCreateProductView ? "Create a Product" : "Create Area of Work")
        .font(.headline)
      
      HStack {
        Spacer()
        
        Button {
          withAnimation(.easeInOut) {
            showCreateProductView.toggle()
          }
        } label: {
          Image(systemName: "chevron.right")
            .font(.system(size: 24, weight: .regular))
            .foregroundColor(.primary)
            .rotationEffect(.degrees(showCreateProductView ? 0 : 180))
        }
      }
    }
    .padding(.horizontal)
  }
  
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
  
  private var createProductView: some View {
    ScrollView {
        VStack(spacing: 20) {
          imageView
            .padding(40)
            .fullScreenCover(isPresented: $showCamera) {
              CameraView()
            }
          
          UnderlinedTextField(text: $consumableVM.sapId, activeIcon: "doc.text.image.fill", defaultIcon: "doc.text.image", placeholder: "Sap Id")
            .keyboardType(.numberPad)
          
          UnderlinedTextField(text: $consumableVM.description, activeIcon: "doc.text.image.fill", defaultIcon: "doc.text.image", placeholder: "Description")
          
          DropdownPicker(title: "Unit of Measure", selection: $selection, options: Consumable.UnitOfMeasure.allCases.map({ $0.rawValue }))
          
          HStack(spacing: 20) {
            Text("B01")
              .foregroundColor(consumableVM.isPrd ? .primary : .white)
              .frame(height: 55)
              .frame(maxWidth: .infinity)
              .background(
                ZStack {
                  Color.clear
                  if !consumableVM.isPrd {
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
                  consumableVM.isPrd = false
                }
              }
            
            
            Text("PRD")
              .foregroundColor(consumableVM.isPrd ? .white : .primary)
              .frame(height: 55)
              .frame(maxWidth: .infinity)
              .background(
                ZStack {
                  Color.clear
                  if consumableVM.isPrd {
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
                  consumableVM.isPrd = true
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
  }
  
  private var createAreaOfWorkView: some View {
    ScrollView {
      VStack(spacing: 20) {
        UnderlinedTextField(text: $areaOfWorkVM.serviceOrder, activeIcon: "doc.text.image.fill", defaultIcon: "doc.text.image", placeholder: "Service Order")
          .keyboardType(.numberPad)
        
        UnderlinedTextField(text: $areaOfWorkVM.description, activeIcon: "doc.text.image.fill", defaultIcon: "doc.text.image", placeholder: "Description")
        
        Button(action: {
          Task {
            let success = await areaOfWorkVM.create()
            
            if success {
              DispatchQueue.main.async {
                dismiss()
              }
            }
          }
        }) {
          Text("Create".uppercased())
            .blockCapsuleButtonStyle()
        }
        .buttonStyle(.withPressableButtonStyle)
      }
    }
    .frame(maxWidth: .infinity)
    .padding(.horizontal)
  }
}

struct CreateView_Previews: PreviewProvider {
  static var previews: some View {
    CreateView()
  }
}
