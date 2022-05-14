//
//  HomeViewModel.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 29/1/2022.
//

import Foundation

final class HomeViewModel: ObservableObject {
  
  @Published var areaOfWorkDtos: [AreaOfWorkDto] = []
  
  @Published var isLoading: Bool = false
  @Published var showAlert: Bool = false
  @Published var errorMessage: String? = nil
  
  @Inject private var service: AreaOfWorkRepository
  
  @MainActor
  func list() async {
    
    isLoading.toggle()
    
    defer {
      isLoading.toggle()
    }
    
    do {
      try await Task.sleep(nanoseconds: 2_000_000_000) // add 2 second delay
      
      areaOfWorkDtos = try await service.list()
      
    } catch {
      print("ERROR\n\(error.localizedDescription)")
      showAlert = true
      errorMessage = error.localizedDescription
    }
  }
}
