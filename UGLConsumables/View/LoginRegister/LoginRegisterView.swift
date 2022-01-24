//
//  LoginRegisterView.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 22/1/2022.
//

import SwiftUI


struct LoginRegisterView: View {
  
  @Environment(\.colorScheme) var colorScheme
  @AppStorage("isLightTheme") private var isLightTheme: Bool = true


  @State private var email: String = ""
  @State private var password: String = ""
  
  @State private var isSignupPageDisplayed: Bool = false
  
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
        
        
        loginView
          .padding()
        
        Spacer()
        
        Text("All Rights Reserved © Aybars Acar")
          .font(.footnote)
          .foregroundColor(.secondary)
      }
      .sheet(isPresented: $isSignupPageDisplayed) {
        registerView
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
      LoginRegisterView()
    }
  }
}


extension LoginRegisterView {
  
  private var loginView: some View {
      VStack(spacing: 20) {
        
        Text("Welcome back")
          .font(.title2)
          .fontWeight(.semibold)
        
        UnderlinedTextField(
          text: $email,
          activeIcon: "person.fill",
          defaultIcon: "person",
          placeholder: "Email"
        )
              
        UnderlinedTextField(
          text: $password,
          activeIcon: "key.fill",
          defaultIcon: "key",
          placeholder: "Password"
        )
        
        
        HStack {
          Spacer()
          Text("Forgot Password?")
            .font(.footnote)
            .foregroundColor(.secondary)
            .padding()
            .onTapGesture {
              isSignupPageDisplayed.toggle()
            }
        }
        
        Button(action: {}) {
          Text("Login".uppercased())
            .blockCapsuleButtonStyle()
            .padding(.horizontal)
        }
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
  
  private var registerView: some View {
    VStack {
      
      UnderlinedTextField(
        text: $email,
        activeIcon: "person.fill",
        defaultIcon: "person",
        placeholder: "Username"
      )
      
      UnderlinedTextField(
        text: $email,
        activeIcon: "person.fill",
        defaultIcon: "person",
        placeholder: "Email"
      )
      
      UnderlinedTextField(
        text: $password,
        activeIcon: "key.fill",
        defaultIcon: "key",
        placeholder: "Password"
      )
      
      UnderlinedTextField(
        text: $password,
        activeIcon: "key.fill",
        defaultIcon: "key",
        placeholder: "Confirm Password"
      )
      
      Spacer()
      
      Button(action: {}) {
        Text("Register".uppercased())
          .blockCapsuleButtonStyle()
      }
      .buttonStyle(.withPressableButtonStyle)
    }
    .padding()
  }
  
  
  enum CardState {
    case login, register
  }
}
