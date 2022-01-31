//
//  RegisterView.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 25/1/2022.
//

import SwiftUI


struct RegisterView: View {
  
  @Environment(\.presentationMode) private var presentationMode
  
  @StateObject private var viewModel = RegisterViewModel()
  
  var body: some View {
    VStack(spacing: 20) {
      
      VStack(alignment: .leading) {
        Text("Welcome UGL App")
          .font(.title2)
        .fontWeight(.semibold)
      
      Text("Please fill in the information below to register to app")
        .font(.caption)
        .multilineTextAlignment(.center)
      }
      .padding()
      .padding(.vertical)
      
      Image("i1")
        .renderingMode(.template)
        .resizable()
        .frame(width: 200, height: 200)
        .foregroundColor(.theme.blue.opacity(0.6))
      
      UnderlinedTextField(
        text: $viewModel.username,
        activeIcon: "person.fill",
        defaultIcon: "person",
        placeholder: "Username"
      )
      
      UnderlinedTextField(
        text: $viewModel.email,
        activeIcon: "person.fill",
        defaultIcon: "person",
        placeholder: "Email"
      )
      
      UnderlinedTextField(
        text: $viewModel.password,
        activeIcon: "key.fill",
        defaultIcon: "key",
        placeholder: "Password",
        type: .secure
      )
      
      UnderlinedTextField(
        text: $viewModel.confirmPassword,
        activeIcon: "key.fill",
        defaultIcon: "key",
        placeholder: "Confirm Password",
        type: .secure
      )
      
      Button(action: {
        Task {
          await viewModel.signUp()
        }
      }) {
        
        Group{
          if !viewModel.isLoading {
            Text("Register".uppercased())
          } else {
            ProgressView()
              .tint(.white)
          }
        }
          .blockCapsuleButtonStyle()
          .padding(.horizontal)
      }
      .disabled(viewModel.isLoading)
      .buttonStyle(.withPressableButtonStyle)
      .padding()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .overlay(
      Image(systemName: "xmark")
        .padding()
        .onTapGesture {
          presentationMode.wrappedValue.dismiss()
        },
      alignment: .topLeading
    )
    .overlay(alignment: .bottom) {
      SnackbarView(isDisplayed: $viewModel.showAlert, message: viewModel.errorMessage, type: .error) {
        viewModel.showAlert = false
        viewModel.errorMessage = nil
      }
    }
  }
}



struct RegisterView_Previews: PreviewProvider {
  static var previews: some View {
    RegisterView()
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
