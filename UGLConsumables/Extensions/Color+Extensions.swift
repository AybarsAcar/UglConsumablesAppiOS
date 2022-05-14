//
//  Color+Extensions.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 22/1/2022.
//

import Foundation
import SwiftUI

extension Color {
  static let theme = AppColorTheme()
}


struct AppColorTheme {
  
  let red = Color("Red")
  let green = Color("Green")
  let blue = Color("Blue")
  let surface = Color("Surface")
  
  let button = ButtonColors()
  
  struct ButtonColors {
    
  }
}
