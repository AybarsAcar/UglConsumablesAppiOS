//
//  ProfileViewModel.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 28/1/2022.
//

import Foundation
import SwiftUI


class ProfileViewModel: ObservableObject {
  
  private let _coreData: UserDataService
  
  init() {
    _coreData = UserDataService()
  }
  
  
  func logout() {
    withAnimation {
      UserDefaults.standard.set(false, forKey: "isLoggedIn")
      UserDefaults.standard.removeObject(forKey: "token")
    }
    
    _coreData.deleteUser()
  }
}
