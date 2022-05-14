//
//  RegisterViewModel.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 25/1/2022.
//

import Foundation

final class RegisterViewModel: ObservableObject {
  
  @Published var username: String = ""
  @Published var email: String = ""
  @Published var password: String = ""
  @Published var confirmPassword: String = ""
  @Published var account: AccountDto? = nil
  
  @Published var isLoading: Bool = false
  @Published var showAlert: Bool = false
  @Published var errorMessage: String? = nil
  
  @Inject private var service: UserRepository
  @Inject private var localDatabase: UserDataLocalRepository
  
  @MainActor
  func signUp() async {
    
    guard !username.isEmpty && !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty else {
      showAlert = true
      errorMessage = "All fields are requierd to register an account."
      return
    }
    
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
      account = try await service.signUp(with: RegisterAccountDetails(username: username, email: email, password: password))
      
      // clear the form values
      username = ""
      email = ""
      password = ""
      confirmPassword = ""
      
      // save the user token to UserDefaults
      if let token = account?.token {
        UserDefaults.standard.set(token, forKey: "token")
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
      }
      
      // save the user in local device db
      if let user = account?.toUser() {
        localDatabase.update(user: user)
      }
      
    } catch {
      print("ERROR\n\(error.localizedDescription)")
      showAlert = true
      errorMessage = error.localizedDescription
    }
  }
}
