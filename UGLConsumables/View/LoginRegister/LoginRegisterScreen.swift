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
  
  @State private var isSignupPageDisplayed: Bool = false
  @State private var errorMessage: String?
  
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
        
        
        LoginView(message: $errorMessage) {
          isSignupPageDisplayed.toggle()
        }
          .padding()
        
        Spacer()
        
        Text("All Rights Reserved © Aybars Acar")
          .font(.footnote)
          .foregroundColor(.secondary)
      }
      .sheet(isPresented: $isSignupPageDisplayed) {
        RegisterView()
          .padding()
      }
      .overlay(alignment: .bottom) {
        if let errorMessage = errorMessage {
          SnackbarView(message: errorMessage, type: .error) {
            withAnimation(.linear(duration: 0.2)) {
              self.errorMessage = nil
            }
          }
          .padding(.horizontal)
        }
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
