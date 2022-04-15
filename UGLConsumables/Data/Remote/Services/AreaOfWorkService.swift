//
//  AreaOfWorkService.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 29/1/2022.
//

import Foundation


class AreaOfWorkService {
  
  private let domain: String = "https://ugl-consumables.herokuapp.com/api"
  
  private let token = "TOKEN GOES HERE"
  
  
  /// GET request to return all the Area of Works
  /// Request requires Authorization Header with a valid token
  func list() async throws -> [AreaOfWorkDto] {
    
    guard let url = URL(string: "\(domain)/areaOfWork") else {
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
        let areaOfWorkDtos = try decoder.decode([AreaOfWorkDto].self, from: data)
        
        return areaOfWorkDtos
        
      } catch {
        throw APIError.decodingError(error.localizedDescription)
      }
      
    } catch {
      throw APIError.dataTaskError(error.localizedDescription)
    }
  }
}
