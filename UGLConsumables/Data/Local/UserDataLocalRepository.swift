//
//  UserDataLocalRepository.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 14/5/2022.
//

import Foundation

protocol UserDataLocalRepository {
  func getUser()
  func update(user: User)
  func deleteUser()
}
