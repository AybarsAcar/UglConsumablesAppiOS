//
//  CustomTabBarView.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 28/1/2022.
//

import SwiftUI


struct CustomTabBarView: View {
  
  let tabs: [TabBarItem]
  @Binding var selection: TabBarItem
  
  @Namespace private var selectionNamespace
  
  // to animate the navigation but to prevent the screen animation
  @State var localSelection: TabBarItem
  
  var body: some View {
    tabBarVersion2
      .onChange(of: selection) { newValue in
        withAnimation(.easeInOut) {
          localSelection = newValue
        }
      }
  }
}


/// this extension is for 1st custom tab bar
extension CustomTabBarView {
  
  private func tabView(tab: TabBarItem) -> some View {
    VStack {
      Image(systemName: tab.iconName)
        .font(.subheadline)
      
      Text(tab.title)
        .font(.system(size: 10, weight: .semibold, design: .rounded))
    }
    .foregroundColor(localSelection == tab ? tab.color : Color.gray)
    .padding(.vertical, 8)
    .frame(maxWidth: .infinity)
    .background(localSelection == tab ? tab.color.opacity(0.2) : Color.clear)
    .cornerRadius(10)
  }
  
  
  private var tabBarVersion1: some View {
    HStack {
      ForEach(tabs, id: \.self) { tab in
        tabView(tab: tab)
          .onTapGesture {
            switchToTab(tab: tab)
          }
      }
    }
    .padding(6)
    .background(Color.white.ignoresSafeArea(edges: .bottom))
  }
  
  
  private func switchToTab(tab: TabBarItem) {
   selection = tab
  }
}


/// this extension is for 2nd custom tab bar
extension CustomTabBarView {
  
  private func tabView2(tab: TabBarItem) -> some View {
    VStack {
      Image(systemName: tab.iconName)
        .font(.subheadline)
      
      Text(tab.title)
        .font(.system(size: 10, weight: .semibold, design: .rounded))
    }
    .foregroundColor(localSelection == tab ? tab.color : Color.gray)
    .padding(.vertical, 8)
    .frame(maxWidth: .infinity)
    .background(
      ZStack {
        if localSelection == tab {
          RoundedRectangle(cornerRadius: 10)
            .fill(tab.color)
            .frame(width: 40, height: 4)
            .offset(y: 20)
            .matchedGeometryEffect(id: "background_rectangle", in: selectionNamespace)
        }
      }
    )
  }
  
  
  private var tabBarVersion2: some View {
    HStack {
      ForEach(tabs, id: \.self) { tab in
        tabView2(tab: tab)
          .onTapGesture {
            switchToTab(tab: tab)
          }
      }
    }
    .padding(6)
    .background(Color.white.ignoresSafeArea(edges: .bottom))
    .cornerRadius(10)
    .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 5)
    .padding(.horizontal)
  }
}



struct CustomTabBarView_Previews: PreviewProvider {
  static let tabs: [TabBarItem] = [.home, .messages, .profile, .dashboard]
  
  static var previews: some View {
    VStack {
      Spacer()
      CustomTabBarView(tabs: tabs, selection: .constant(tabs.first!), localSelection: tabs.first!)
    }
  }
}
