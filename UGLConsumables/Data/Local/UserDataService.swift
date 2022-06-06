//
//  UserDataService.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 28/1/2022.
//

import Foundation
import CoreData

final class UserDataService: UserDataLocalRepository {
  
  @Published var userEntity: UserEntity? = nil
  
  private let container: NSPersistentContainer
  private let containerName: String = "UGLConsumablesContainer"
  private let entityName: String = "UserEntity"
  
  init() {
    container = NSPersistentContainer(name: containerName)
    container.loadPersistentStores { _, error in
      if let error = error {
        print("Error loaading Core Data:\n\(error)")
      }
      
      // get the user
      self.getUser()
    }
  }
  
  /// returns the user stored in CoreData
  func getUser() {
    let request = NSFetchRequest<UserEntity>(entityName: entityName)
    
    do {
      userEntity = try container.viewContext.fetch(request).first
      
    } catch {
      print("Error fetching the user:\n\(error)")
    }
  }
  
  /// updates the user saved in CoreData if the user exists
  /// if the user does not exists creates a new user
  func update(user: User) {
    if let entity = userEntity {
      entity.username = user.username
      entity.email = user.username
      entity.department = user.username
      
      applyChanges()
    } else {
      // create
      create(user: user)
    }
  }
  
  /// removes the currently logged in user details from CoreData
  /// called when the user logs out
  func deleteUser() {
    if let userEntity = userEntity {
      container.viewContext.delete(userEntity)
      save()
    }
  }
  
  private func create(user: User) {
    
    let entity = UserEntity(context: container.viewContext)
    
    // map the values
    entity.username = user.username
    entity.email = user.email
    entity.department = user.department
    
    applyChanges()
  }
  
  private func save() {
    
    do {
      try container.viewContext.save()
    } catch {
      print("Error saving changes to Core Data:\n\(error)")
    }
  }
  
  
  private func applyChanges() {
    save()
    getUser()
  }
}
