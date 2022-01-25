//
//  RegisterViewModel.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 25/1/2022.
//

import Foundation


class RegisterViewModel: ObservableObject {
  
  @Published var username: String = ""
  @Published var email: String = ""
  @Published var password: String = ""
  @Published var confirmPassword: String = ""
  @Published var user: AccountDto? = nil
  
  @Published var isLoading: Bool = false
  @Published var showAlert: Bool = false
  @Published var errorMessage: String? = nil
  
  private let _service: UserService
  
  init() {
    _service = UserService()
  }
  
  
  @MainActor
  func signUp() async {
    
    guard password == confirmPassword else {
      showAlert = true
      errorMessage = "Passwords do not match"
      return
    }
    
    isLoading.toggle()
    
    defer {
      isLoading.toggle()
    }
    
    do {
      user = try await _service.signUp(with: RegisterAccountDetails(username: username, email: email, password: password))
      if let user = user {
        print(user.email)
      }
    } catch {
      print("ERROR\n\(error.localizedDescription)")
      showAlert = true
      errorMessage = error.localizedDescription
    }
  }
}
