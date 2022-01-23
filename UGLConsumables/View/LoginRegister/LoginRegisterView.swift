//
//  LoginRegisterView.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 22/1/2022.
//

import SwiftUI


struct LoginRegisterView: View {
  
  @Environment(\.colorScheme) var colorScheme

  @State private var email: String = ""
  @State private var password: String = ""
  
  @FocusState private var emailFieldIsFocused: Bool
  @FocusState private var passwordFieldIsFocused: Bool
  
  @State private var selectedCard: CardState = .login
  @Namespace private var cardState
  
  
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
        
        Spacer()
        
        Image("Logo")
          .resizable()
          .renderingMode(.template)
          .foregroundColor(.white)
          .scaledToFit()
          .frame(width: 200, height: 200)
        
        Spacer()
        
        VStack {
          
          HStack(spacing: 40) {
            ZStack {
              Text("Login")
                .font(.title2)
              
              if selectedCard == .login {
                RoundedRectangle(cornerRadius: 10)
                  .fill(.orange)
                  .matchedGeometryEffect(id: "cardState", in: cardState)
                  .frame(width: 40, height: 4)
                  .offset(y: 20)
              }
            }
            .padding()
            .onTapGesture {
              withAnimation(.spring()) {
                selectedCard = .login
              }
            }
            
            
            ZStack {
              Text("Register")
                .font(.title2)
              
              if selectedCard == .register {
                RoundedRectangle(cornerRadius: 10)
                  .fill(.orange)
                  .matchedGeometryEffect(id: "cardState", in: cardState)
                  .frame(width: 40, height: 4)
                  .offset(y: 20)
              }
            }
            .padding()
            .onTapGesture {
              withAnimation(.spring()) {
                selectedCard = .register
              }
            }
          }
          
          if selectedCard == .login {
            loginView
              .transition(.move(edge: .leading))
          }
          
          if selectedCard == .register {
            VStack {
              registerView
                .transition(.move(edge: .trailing))
            }
          }
          
          Spacer(minLength: 50)
        }
        .background(Color.theme.surface)
        .cornerRadius(40)
        .frame(height: 500)
        .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 10)
        .padding()
      }
      .ignoresSafeArea()
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
      
      HStack {
        Image(systemName: emailFieldIsFocused ? "person.fill" : "person")
          .foregroundColor(emailFieldIsFocused ? .theme.blue : .secondary)
        
        TextField("Email", text: $email)
          .textInputAutocapitalization(.never)
          .focused($emailFieldIsFocused)
          .padding()
      }
      .overlay {
        Rectangle()
          .fill(emailFieldIsFocused ? Color.theme.blue : .secondary)
          .frame(height: 2)
          .padding(.top, 60)
      }
            
      
      HStack {
        Image(systemName: passwordFieldIsFocused ? "key.fill" : "key")
          .foregroundColor(passwordFieldIsFocused ? .theme.blue : .secondary)
        
        SecureField("Password", text: $password)
          .focused($passwordFieldIsFocused)
          .padding()
        
        Image(systemName: "lock")
          .foregroundColor(.secondary)
      }
      .overlay {
        Rectangle()
          .fill(passwordFieldIsFocused ? Color.theme.blue : .secondary)
          .frame(height: 2)
          .padding(.top, 60)
      }
     
      
      Spacer()
      
      Button(action: {}) {
        Text("Login".uppercased())
          .blockCapsuleButtonStyle()
      }
      .buttonStyle(.withPressableButtonStyle)
      
      HStack {
        Spacer()
        Text("Forgot Password?")
          .font(.footnote)
          .foregroundColor(.secondary)
          .padding()
          .onTapGesture {
            
          }
      }
      
      Spacer()
    }
    .frame(maxWidth: .infinity)
    .padding()
  }
  
  private var registerView: some View {
    VStack {
      
      HStack {
        Image(systemName: "person")
        TextField("Username", text: $email)
          .padding()
      }
      
      TextField("Email", text: $email)
        .padding()
      
      SecureField("Password", text: $password)
        .padding()
      
      SecureField("Confirm Password", text: $password)
        .padding()
      
      Spacer()
      
      Button(action: {}) {
        Text("Register".uppercased())
          .blockCapsuleButtonStyle()
      }
      .buttonStyle(.withPressableButtonStyle)
      
      Spacer()
    }
    .frame(maxWidth: .infinity)
    .padding()
  }
  
  
  enum CardState {
    case login, register
  }
}
