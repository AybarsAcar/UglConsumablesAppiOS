//
//  LoginViewModel.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 25/1/2022.
//

import Foundation


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
    
    isLoading.toggle()
    
    defer {
      isLoading.toggle()
    }
    
    do {
      user = try await _service.login(with: LoginAccountDetails(email: email, password: password))
      
    } catch {
      print("ERROR\n\(error.localizedDescription)")
      showAlert = true
      errorMessage = error.localizedDescription
    }
  }
}
