//
//  CustomTabBarContainerView.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 28/1/2022.
//

import SwiftUI


struct CustomTabBarContainerView<Content>: View where Content : View {
  
  @Binding var selection: TabBarItem
  let content: Content
  
  // we will update it with .tabItem we create
  @State private var tabs: [TabBarItem] = []
  
  init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
    self._selection = selection
    self.content = content()
  }
  
  var body: some View {
    
    ZStack(alignment: .bottom) {
      content
        .ignoresSafeArea()
      
      CustomTabBarView(tabs: tabs, selection: $selection, localSelection: selection)
    }
    .onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
      // update the tabs
      self.tabs = value
    }
  }
}



struct CustomTabBarContainerView_Previews: PreviewProvider {
  static let tabs: [TabBarItem] = [.home, .messages, .profile, .dashboard]
    
    static var previews: some View {
      CustomTabBarContainerView(selection: .constant(tabs.first!)) {
        Color.red
      }
    }
}
