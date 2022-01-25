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
}
