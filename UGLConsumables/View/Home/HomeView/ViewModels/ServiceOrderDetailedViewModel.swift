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
  
  let sapID: Int
  
  @Inject private var service: ConsumableRepository
  
  init(sapID: Int) {
    self.sapID = sapID
    
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
      
      consumables = try await service.list(by: self.sapID)
      
    } catch {
      print("ERROR\n\(error.localizedDescription)")
      showAlert = true
      errorMessage = error.localizedDescription
    }
  }
}
