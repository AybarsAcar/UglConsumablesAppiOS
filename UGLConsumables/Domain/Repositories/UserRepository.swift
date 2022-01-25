//
//  UserRepository.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 25/1/2022.
//

import Foundation

protocol UserRepository {
  
  func signUp(by user: RegisterAccountDetails) async throws -> AccountDto
  
  func login(by user: LoginAccountDetails) async throws -> AccountDto
  
  func getUsers() async throws -> [AccountDto]
  
  func getUserByEmail(_ email: String) async throws -> AccountDto
  
  func getCurrentUser(token: String) async throws -> AccountDto
}
