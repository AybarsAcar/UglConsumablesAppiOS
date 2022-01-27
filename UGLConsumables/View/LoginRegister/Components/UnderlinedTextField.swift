//
//  UnderlinedTextField.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 24/1/2022.
//

import SwiftUI


struct UnderlinedTextField: View {
  
  enum UnderlinedTextFieldType {
    case plain, secure
  }
  
  @Binding var text: String
  @FocusState var isFocused: Bool
  
  let activeIcon: String
  let defaultIcon: String
  let placeholder: String
  let activeColor: Color
  let defaultColor: Color
  let type: UnderlinedTextFieldType
  
  @State private var secure: Bool = true
  
  init(
    text: Binding<String>,
    activeIcon: String,
    defaultIcon: String,
    placeholder: String,
    activeColor: Color = .theme.blue,
    defaultColor: Color = .secondary,
    type: UnderlinedTextFieldType = .plain
  ) {
    self._text = text
    self.activeIcon = activeIcon
    self.defaultIcon = defaultIcon
    self.placeholder = placeholder
    self.activeColor = activeColor
    self.defaultColor = defaultColor
    self.type = type
  }
  
  var body: some View {
    
    switch type {
    case .plain:
      plainTextField
      
    case .secure:
     secureTextField
    }
  }
}


extension UnderlinedTextField {
  
  private var plainTextField: some View {
    HStack {
      Image(systemName: isFocused ? activeIcon : defaultIcon)
        .foregroundColor(isFocused ? activeColor : defaultColor)
      
      TextField(placeholder, text: $text)
        .textInputAutocapitalization(.never)
        .focused($isFocused)
        .padding()
    }
    .overlay {
      Rectangle()
        .fill(isFocused ?  activeColor : defaultColor)
        .frame(height: 2)
        .padding(.top, 60)
    }
  }
  
  private var secureTextField: some View {
    HStack {
      Image(systemName: isFocused ? activeIcon : defaultIcon)
        .foregroundColor(isFocused ? activeColor : defaultColor)
      
      if !secure {
        
        TextField(placeholder, text: $text)
          .textInputAutocapitalization(.never)
          .disableAutocorrection(true)
          .focused($isFocused)
          .padding()
        
      } else {
        SecureField(placeholder, text: $text)
          .textInputAutocapitalization(.never)
          .disableAutocorrection(true)
          .focused($isFocused)
          .padding()
      }
      
      Image(systemName: secure ? "eye.fill" : "eye.slash.fill")
        .foregroundColor(.secondary)
        .onTapGesture {
          secure.toggle()
        }
    }
    .overlay {
      Rectangle()
        .fill(isFocused ?  activeColor : defaultColor)
        .frame(height: 2)
        .padding(.top, 60)
    }
  }
}



struct UnderlinedTextField_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ZStack {
        UnderlinedTextField(text: .constant("Default"), activeIcon: "person.fill", defaultIcon: "person", placeholder: "Email", activeColor: .theme.blue, defaultColor: .secondary)
      }
      
      ZStack {
        UnderlinedTextField(text: .constant("Default"), activeIcon: "person.fill", defaultIcon: "person", placeholder: "Email", activeColor: .theme.blue, defaultColor: .secondary)
      }
      .preferredColorScheme(.dark)
    }
    .previewLayout(.sizeThatFits)
    .padding()
  }
}
