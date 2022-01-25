//
//  LoginView.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 25/1/2022.
//

import SwiftUI

struct LoginView: View {
  
  @StateObject private var viewModel = LoginViewModel()
  let onClick: () -> Void
  
  var body: some View {
    
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
        placeholder: "Password"
      )
      
      
      HStack {
        Spacer()
        Text("Forgot Password?")
          .font(.footnote)
          .foregroundColor(.secondary)
          .padding()
          .onTapGesture {
            onClick()
          }
      }
      
      Button(action: {}) {
        Text("LOGIN")
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
}



struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView { }
      .previewLayout(.sizeThatFits)
      .padding(40)
  }
}
