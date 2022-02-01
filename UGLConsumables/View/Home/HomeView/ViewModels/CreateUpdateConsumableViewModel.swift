//
//  CreateUpdateConsumableViewModel.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 1/2/2022.
//

import Foundation


final class CreateUpdateConsumableViewModel: ObservableObject {
  
  @Published var sapId: String = ""
  @Published var description: String = ""
  @Published var unitOfMeasure: String = ""
  @Published var isPrd: Bool = false
  @Published var serviceOrderIds: [Int] = []
}
