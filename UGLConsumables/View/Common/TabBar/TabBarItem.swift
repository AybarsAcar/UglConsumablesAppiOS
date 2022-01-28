//
//  TabBarItem.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 28/1/2022.
//

import Foundation
import SwiftUI


/// Tab bar item is the domain of the tabs in our application
/// each tab bar item represents a tab in the home view
enum TabBarItem: Hashable {
  case home, profile, messages, dashboard
  
  var iconName: String {
    switch self {
    case .home: return "house"
    case .profile: return "person"
    case .messages: return "message"
    case .dashboard: return "square.split.2x2"
    }
  }
  
  var title: String {
    switch self {
    case .home: return "Home"
    case .profile: return "Profile"
    case .messages: return "Messages"
    case .dashboard: return "Dashboard"
    }
  }
  
  var color: Color {
    switch self {
    case .home: return .red
    case .profile: return .blue
    case .messages: return .green
    case .dashboard: return .orange
    }
  }
}
