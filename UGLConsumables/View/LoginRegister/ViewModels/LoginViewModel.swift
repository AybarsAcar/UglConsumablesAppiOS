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
}
