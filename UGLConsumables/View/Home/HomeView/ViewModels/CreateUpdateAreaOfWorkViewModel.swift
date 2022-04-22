//
//  CreateUpdateAreaOfWorkViewModel.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 15/4/2022.
//

import Foundation

final class CreateUpdateAreaOfWorkViewModel: ObservableObject {
  @Published var serviceOrder: String = ""
  @Published var description: String = ""
  
  @Published private(set) var isLoading: Bool = false
  @Published private(set) var success: Bool = false
  @Published private(set) var errorMessage: String? = nil

  private let _service: AreaOfWorkService
  
  init() {
    _service = AreaOfWorkService()
  }
  
  @MainActor
  func create() async -> Bool {
    isLoading.toggle()
    
    defer {
      isLoading.toggle()
    }
    
    guard let serviceOrderID = Int(serviceOrder) else {
      return false
    }
    
    do {
      try await Task.sleep(nanoseconds: 2_000_000_000) // add 2 second delay
      success = try await _service.create(with: AreaOfWorkFormValues(description: description, serviceOrder: serviceOrderID))
      
      // clear the form values
      serviceOrder = ""
      description = ""
      
      return true
            
    } catch {
      print("ERROR\n\(error.localizedDescription)")
      success = false
      errorMessage = error.localizedDescription
      
      return false
    }
  }
}
