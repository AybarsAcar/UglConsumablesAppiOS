//
//  HomeScreen.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 28/1/2022.
//

import SwiftUI


struct HomeScreen: View {
  
  @State private var selection: String = "Home"
  @State private var tabSelection: TabBarItem = .home
  
  var body: some View {
    CustomTabBarContainerView(selection: $tabSelection) {
      NavigationView{
        HomeView()
      }
      .tabBarItem(tab: .home, selection: $tabSelection)
      
      NavigationView {
        ProfileView()
      }
      .tabBarItem(tab: .profile, selection: $tabSelection)
      
      Color.orange
        .tabBarItem(tab: .messages, selection: $tabSelection)
      
      
      Color.red
        .tabBarItem(tab: .dashboard, selection: $tabSelection)
    }
  }
}



struct HomeScreen_Previews: PreviewProvider {
  static var previews: some View {
    HomeScreen()
  }
}
