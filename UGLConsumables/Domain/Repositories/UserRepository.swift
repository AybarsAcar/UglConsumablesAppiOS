//
//  UserRepository.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 25/1/2022.
//

import Foundation

protocol UserRepository {
  
  func signUp(with user: RegisterAccountDetails) async throws -> AccountDto
  
  func login(with user: LoginAccountDetails) async throws -> AccountDto
  
//  func getUsers() async throws -> [AccountDto]
//  
//  func getUserByEmail(_ email: String) async throws -> AccountDto
//  
//  func getCurrentUser(token: String) async throws -> AccountDto
}
