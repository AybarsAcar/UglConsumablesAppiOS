//
//  AreaOfWorkDto.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 29/1/2022.
//

import Foundation


struct AreaOfWorkDto: Codable, Identifiable {
  let id: Int
  let description: String
  let serviceOrder: Int
}
