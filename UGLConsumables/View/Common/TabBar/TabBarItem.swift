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
  case home, profile, messages, dashboard, order
  
  var iconName: String {
    switch self {
    case .home: return "house"
    case .profile: return "person"
    case .messages: return "message"
    case .dashboard: return "square.split.2x2"
    case .order: return "plus.square"
    }
  }
  
  var activeIconName: String {
    switch self {
    case .home: return "house.fill"
    case .profile: return "person.fill"
    case .messages: return "message.fill"
    case .dashboard: return "square.split.2x2.fill"
    case .order: return "plus.square.fill"
    }
  }
  
  var title: String {
    switch self {
    case .home: return "Home"
    case .profile: return "Profile"
    case .messages: return "Messages"
    case .dashboard: return "Dashboard"
    case .order: return "Orders"
    }
  }
  
  var color: Color {
    switch self {
    case .home: return .red
    case .profile: return .blue
    case .messages: return .green
    case .dashboard: return .orange
    case .order: return .orange
    }
  }
}
