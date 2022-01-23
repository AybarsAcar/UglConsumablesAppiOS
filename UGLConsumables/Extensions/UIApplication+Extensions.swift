//
//  UIApplication+Extensions.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 23/1/2022.
//

import Foundation
import SwiftUI

extension UIApplication {
  
  /// extension function to dismiss the keyboard
  /// ```
  /// UIApplication.shared.endEditing()
  /// ```
  func endEditing() {
    
    // send an obj-c function to dissmiss the keyboard
    sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
  
}
