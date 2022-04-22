//
//  Consumable.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 1/2/2022.
//

import Foundation

struct Consumable: Identifiable, Codable {
  let id: Int
  let sapID: Int
  let description: String
  let unitOfMeasure: UnitOfMeasure
  let isPrd: Bool
  let quantity: Int
  let areaOfWorks: [AreaOfWorkDto]
  
  
  enum UnitOfMeasure: String, Codable, CaseIterable {
    case each = "EA"
    case metre = "M"
    case liter = "L"
    case box = "BOX"
    case packet = "PAC"
  }
}
