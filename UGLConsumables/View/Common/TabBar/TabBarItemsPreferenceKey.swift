//
//  TabBarItemsPreferenceKey.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 28/1/2022.
//

import Foundation
import SwiftUI


struct TabBarItemsPreferenceKey: PreferenceKey {
  
  static var defaultValue: [TabBarItem] = []
  
  /// every time we add a new item to the tab bar
  /// we append to teh preference key
  static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
    value += nextValue()
  }
}


struct TabBarItemViewModifier: ViewModifier {
  
  let tab: TabBarItem
  @Binding var selection: TabBarItem
  
  func body(content: Content) -> some View {
    content
      .opacity(selection == tab ? 1.0 : 0.0)
      .preference(key: TabBarItemsPreferenceKey.self, value: [tab])
  }
}


extension View {
  
  func tabBarItem(tab: TabBarItem, selection: Binding<TabBarItem>) -> some View {
    self
      .modifier(TabBarItemViewModifier(tab: tab, selection: selection))
  }
}
