//
//  ConsumableDto.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 31/1/2022.
//

import Foundation


struct ConsumableDto: Identifiable, Codable {
  let id: Int
  let sapId: Int
  let description: String
  let unitOfMeasure: String
  let isPrd: Bool
  let quantity: Int
  let areaOfWorks: [AreaOfWorkDto]
}


struct CreateConsumableFormValues: Codable {
  let sapId: Int
  let description: String
  let unitOfMeasure: String
  let isPrd: Bool
  let serviceOrderIds: [Int]
}
