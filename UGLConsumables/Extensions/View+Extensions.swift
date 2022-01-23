//
//  View+Extensions.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 23/1/2022.
//

import Foundation
import SwiftUI


extension View {
  
  func underlineTextFieldStyle() -> some View {
    self
      .overlay(Rectangle().frame(height: 2).padding(.top, 50))
      .foregroundColor(.theme.blue)
  }
}
