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
  @Published var user: AccountDto? = nil
  
  @Published var isLoading: Bool = false
  @Published var showAlert: Bool = false
  @Published var errorMessage: String? = nil
  
  private let _service: UserService
  
  init() {
    _service = UserService()
  }
  
  
  @MainActor
  func login() async {
    
    showAlert = false
    isLoading.toggle()
    
    defer {
      isLoading.toggle()
    }
    
    do {
      try await Task.sleep(nanoseconds: 2_000_000_000) // add 2 second delay
      user = try await _service.login(with: LoginAccountDetails(email: email, password: password))
      
      email = ""
      password = ""
      
    } catch {
      print("ERROR\n\(error.localizedDescription)")
      showAlert = true
      errorMessage = error.localizedDescription
    }
  }
}
