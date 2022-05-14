//
//  AreaOfWorkRepository.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 14/5/2022.
//

import Foundation

protocol AreaOfWorkRepository {
  
  /// GET request to return all the Area of Works
  /// Request requires Authorization Header with a valid token
  func list() async throws -> [AreaOfWorkDto]
  
  /// POST request to create an area of work
  /// Request requires Authorization Header with a valid token
  func create(with areaOfWorkFormValues: AreaOfWorkFormValues) async throws -> Bool
}
