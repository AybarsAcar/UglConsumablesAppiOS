//
//  LoginViewModel.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 25/1/2022.
//

import Foundation
import SwiftUI


class LoginViewModel: ObservableObject {
  
  @Published var email: String = ""
  @Published var password: String = ""
  @Published var account: AccountDto? = nil
  
  @Published var isLoading: Bool = false
  @Published var showAlert: Bool = false
  @Published var errorMessage: String? = nil
  
  private let _service: UserService
  private let _coreData: UserDataService
  
  init() {
    _service = UserService()
    _coreData = UserDataService()
  }
  
  
  @MainActor
  func login() async {
    
    guard !email.isEmpty && !password.isEmpty else {
      showAlert = true
      errorMessage = "Please enter your email and password."
      return
    }
    
    showAlert = false
    isLoading.toggle()
    
    defer {
      isLoading.toggle()
    }
    
    do {
      try await Task.sleep(nanoseconds: 2_000_000_000) // add 2 second delay
      account = try await _service.login(with: LoginAccountDetails(email: email, password: password))
      
      // clear the form values
      email = ""
      password = ""
      
      // save the user token to UserDefaults
      if let token = account?.token {
        UserDefaults.standard.set(token, forKey: "token")
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
      }
      
      // save the user in local device db
      if let user = account?.toUserModel() {
        _coreData.update(user: user)
      }
      
    } catch {
      print("ERROR\n\(error.localizedDescription)")
      showAlert = true
      errorMessage = error.localizedDescription
    }
  }
}
