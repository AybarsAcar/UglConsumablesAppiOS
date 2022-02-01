//
//  ConsumableService.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 1/2/2022.
//

import Foundation


class ConsumableService {
  
  private let domain: String = "http://127.0.0.1:5000/api"
  
  private let token = "THIS TOKEN IS STORED IN DEVICE"
  
  
  /// GET request to return all the Consumables by Sap Id
  /// of the Service Order area
  /// if no sapId is passed in it returns all the Consumable items in db
  func list(by sapId: Int) async throws -> [ConsumableDto] {
    
    guard let url = URL(string: "\(domain)/Consumable?serviceOrderId=\(sapId)") else {
      throw APIError.invalidURL
    }
    
    // build up the request
    var request = URLRequest(url: url)
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    do {
      let (data, response) = try await URLSession.shared.data(for: request)
      
      guard let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
      else {
        throw APIError.invalidResponseStatus
      }
      
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .deferredToDate
      decoder.keyDecodingStrategy = .useDefaultKeys
      
      do {
        let consumableDtos = try decoder.decode([ConsumableDto].self, from: data)
        
        return consumableDtos
        
      } catch {
        throw APIError.decodingError(error.localizedDescription)
      }
      
    } catch {
      throw APIError.dataTaskError(error.localizedDescription)
    }
  }
}
