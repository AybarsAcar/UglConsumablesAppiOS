//
//  UGLButton.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 23/1/2022.
//

import Foundation
import SwiftUI


/// ButtonStyle when pressed
struct PressableButtonStyle: ButtonStyle {
  
  let scaleAmount: CGFloat
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .opacity(configuration.isPressed ? 1.0 : 1.0)
      .brightness(configuration.isPressed ? 0.05 : 0)
      .scaleEffect(configuration.isPressed ? scaleAmount : 1.0)
  }
}

extension ButtonStyle where Self == PressableButtonStyle {
  
  static var withPressableButtonStyle: Self {
    return .init(scaleAmount: 0.95)
  }
  
  static func withPressableButtonStyle(scaleAmount: CGFloat) -> Self {
    return .init(scaleAmount: scaleAmount)
  }
}


/// Full width main action button stle
extension View {
  func blockCapsuleButtonStyle(backgroundColor: Color = .theme.blue, foregroundColor: Color = .white) -> some View {
    self
      .font(.title3)
      .foregroundColor(foregroundColor)
      .frame(height: 55)
      .frame(maxWidth: .infinity)
      .background(backgroundColor)
      .cornerRadius(100)
  }
}
