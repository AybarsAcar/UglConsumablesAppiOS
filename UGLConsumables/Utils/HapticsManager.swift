//
//  HapticsManager.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 22/4/2022.
//

import SwiftUI

final class HapticsManager {
  static let shared = HapticsManager()
  private init() { }
  
  public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
    DispatchQueue.main.async {
      let generator = UINotificationFeedbackGenerator()
      generator.prepare()
      
      generator.notificationOccurred(type)
    }
  }
  
  public func impact(withStyle style: UIImpactFeedbackGenerator.FeedbackStyle) {
    DispatchQueue.main.async {
      let generator = UIImpactFeedbackGenerator(style: style)
      generator.impactOccurred()
    }
  }
}
