//
//  ConsumableRepository.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 14/5/2022.
//

import Foundation

protocol ConsumableRepository {
  
  /// GET request to return all the Consumables by Sap Id
  /// of the Service Order area
  /// if no sapId is passed in it returns all the Consumable items in db
  func list(by sapId: Int) async throws -> [ConsumableDto]
}
