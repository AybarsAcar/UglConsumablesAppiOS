//
//  SnackbarView.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 26/1/2022.
//

import SwiftUI

struct SnackbarView: View {
  
  @Binding var isDisplayed: Bool
  let message: String?
  let type: SnackbarType
  let onDismiss: () -> Void
  
  @State private var animate: Bool = false
  
  var body: some View {
    
    HStack {
      Image(systemName: getSystemImageName())
        .font(.title2)
      
      Spacer(minLength: 4)
      
      if let message = message {
        Text(message)
          .multilineTextAlignment(.leading)
          .font(.headline)
      }
      
      Spacer(minLength: 4)
      
      Image(systemName: "xmark")
    }
    .padding()
    .foregroundColor(.white)
    .frame(maxWidth: .infinity)
    .background(getBackgroundColor())
    .cornerRadius(10)
    .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 10)
    .onTapGesture {
      withAnimation(.linear) {
        onDismiss()
      }
    }
    .opacity(isDisplayed ? 1.0 : 0.0)
    
  }
}

extension SnackbarView {
  
  enum SnackbarType {
    case success, warning, error
  }
  
  private func getBackgroundColor() -> Color {
    switch type {
    case .error:
      return .theme.red
    case .success:
      return .theme.green
    case .warning:
      return .yellow
    }
  }
  
  private func getSystemImageName() -> String {
    switch type {
    case .error:
      return "exclamationmark.triangle.fill"
    case .success:
      return "checkmark.seal"
    case .warning:
      return "exclamationmark.triangle"
    }
  }
}



struct SnackbarView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      SnackbarView(isDisplayed: .constant(true), message: "Invalid Credentials", type: .error) { }
      SnackbarView(isDisplayed: .constant(true), message: "Please update your credentials", type: .warning) { }
      SnackbarView(isDisplayed: .constant(true), message: "Successfully Logged In", type: .success) { }
      
      Group {
        SnackbarView(isDisplayed: .constant(true), message: "Invalid Credentials", type: .error) { }
        SnackbarView(isDisplayed: .constant(true), message: "Please update your credentials", type: .warning) { }
        SnackbarView(isDisplayed: .constant(true), message: "Successfully Logged In", type: .success) { }
      }
      .preferredColorScheme(.dark)
    }
    .previewLayout(.sizeThatFits)
    .padding()
  }
}
