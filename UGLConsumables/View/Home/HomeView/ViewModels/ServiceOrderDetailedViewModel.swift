//
//  ServiceOrderDetailedViewModel.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 1/2/2022.
//

import Foundation


final class ServiceOrderDetailedViewModel: ObservableObject {
  
  @Published var consumables: [ConsumableDto] = []
  
  @Published var isLoading: Bool = false
  @Published var showAlert: Bool = false
  @Published var errorMessage: String? = nil
  
  let sapId: Int
  
  private let _service: ConsumableService

  
  init(sapId: Int) {
    _service = ConsumableService()
    self.sapId = sapId
    
    Task {
      await list()
    }
  }
  
  
  @MainActor
  private func list() async {
    isLoading.toggle()
    
    defer {
      isLoading.toggle()
    }
    
    do {
      try await Task.sleep(nanoseconds: 2_000_000_000) // add 2 second delay
      
      consumables = try await _service.list(by: self.sapId)
      
    } catch {
      print("ERROR\n\(error.localizedDescription)")
      showAlert = true
      errorMessage = error.localizedDescription
    }
  }
}
