//
//  ConsumableDto.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 31/1/2022.
//

import Foundation


struct ConsumableDto: Identifiable, Codable {
  let id: Int
  let sapID: Int
  let description: String
  let unitOfMeasure: String
  let isPrd: Bool
  let quantity: Int
  let areaOfWorks: [AreaOfWorkDto]
  
  enum CodingKeys: String, CodingKey {
    case id
    case sapID = "sapId"
    case description = "description"
    case unitOfMeasure, isPrd, quantity, areaOfWorks
  }
}


struct CreateConsumableFormValues: Codable {
  let sapId: Int
  let description: String
  let unitOfMeasure: String
  let isPrd: Bool
  let serviceOrderIds: [Int]
}


/// DTO mappers
extension ConsumableDto {
  func toConsumable() -> Consumable {
    return Consumable(
      id: self.id,
      sapID: self.sapID,
      description: self.description,
      unitOfMeasure: Consumable.UnitOfMeasure(rawValue: self.unitOfMeasure) ?? .each,
      isPrd: self.isPrd,
      quantity: self.quantity,
      areaOfWorks: self.areaOfWorks)
  }
}
