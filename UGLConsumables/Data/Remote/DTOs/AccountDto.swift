//
//  AccountDto.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 22/1/2022.
//

import Foundation


struct AccountDto: Codable {
  let username: String
  let email: String
  let token: String
  let department: String?
}


struct RegisterAccountDetails: Codable {
  let username: String
  let email: String
  let password: String
}


struct LoginAccountDetails: Codable {
  let email: String
  let password: String
}


/// DTO mappers
extension AccountDto {
  
  func toUser() -> User {
    return User(
      username: self.username,
      email: self.email,
      token: self.token,
      department: self.department
    )
  }
}
