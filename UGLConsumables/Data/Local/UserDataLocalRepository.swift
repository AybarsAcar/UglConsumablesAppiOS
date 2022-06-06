//
//  UserDataLocalRepository.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 14/5/2022.
//

import Foundation

protocol UserDataLocalRepository {
  
  /// returns the user stored in CoreData
  func getUser()
  
  /// updates the user saved in CoreData if the user exists
  /// if the user does not exists creates a new user
  func update(user: User)
  
  /// removes the currently logged in user details from CoreData
  /// called when the user logs out
  func deleteUser()
}
