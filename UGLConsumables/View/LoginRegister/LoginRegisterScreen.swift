//
//  LoginRegisterView.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 22/1/2022.
//

import SwiftUI


struct LoginRegisterScreen: View {
  
  @Environment(\.colorScheme) var colorScheme
  @AppStorage("isLightTheme") private var isLightTheme: Bool = true
  
  @State private var isSignUpViewDisplayed: Bool = false
  @State private var errorMessage: String?
  
  @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
  @StateObject private var viewModel = LoginViewModel()
  
  
  var body: some View {
    ZStack {
     
      // Background Layer
      if colorScheme == .light {
        LinearGradient(gradient: Gradient(colors: [.theme.blue, .white]), startPoint: .top, endPoint: .bottom)
          .ignoresSafeArea()
      } else {
        LinearGradient(gradient: Gradient(colors: [.theme.blue, .black]), startPoint: .top, endPoint: .bottom)
          .ignoresSafeArea()
      }
      
      
      VStack {
        HStack {
          Spacer()
          Button(action: {
            isLightTheme.toggle()
          }) {
            Image(systemName: isLightTheme ? "sun.min.fill" : "moon.fill")
              .font(.title)
              .foregroundColor(.white)
              .padding()
          }
        }
        
        Spacer()
        
        Image("Logo")
          .resizable()
          .renderingMode(.template)
          .foregroundColor(.white)
          .scaledToFit()
          .frame(width: 200, height: 200)
        
        
        loginCard
          .padding()
        
        Spacer()
        
        HStack {
          Text("Don't have an account?")
            .font(.footnote)
            .foregroundColor(.secondary)
          
          Text("Sign Up")
            .font(.footnote)
            .fontWeight(.semibold)
            .underline()
            .padding()
            .onTapGesture {
              isSignUpViewDisplayed.toggle()
            }
        }
      }
      .sheet(isPresented: $isSignUpViewDisplayed) {
        
        RegisterView()
          .padding()
      }
      .overlay(alignment: .bottom) {
       // snackbar here
        SnackbarView(isDisplayed: $viewModel.showAlert, message: viewModel.errorMessage, type: .error) {
          viewModel.showAlert = false
          viewModel.errorMessage = nil
        }
        .padding(.horizontal)
      }
    }
    .onTapGesture {
      UIApplication.shared.endEditing()
    }
  }
}



struct LoginRegisterView_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      LoginRegisterScreen()
    }
  }
}


extension LoginRegisterScreen {
  
  private var loginCard: some View {
    VStack(spacing: 20) {
      
      Text("Welcome back")
        .font(.title2)
        .fontWeight(.semibold)
      
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
      
      HStack {
        Spacer()
        Text("Forgot Password?")
          .font(.footnote)
          .foregroundColor(.secondary)
          .padding()
          .onTapGesture {
            // forgot email
          }
      }
      
      Button(action: {
        Task {
        await viewModel.login()
        }
      }) {
        Group{
          if !viewModel.isLoading {
            Text("LOGIN")
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
      .offset(y: 40)
    }
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 12)
        .fill(Color.theme.surface)
    )
    .shadow(color: .black.opacity(0.4), radius: 20, x: 0, y: 20)
  }
}
