//
//  AreaOfWorkService.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 29/1/2022.
//

import Foundation

final class AreaOfWorkService: AreaOfWorkRepository {
  
  private let domain: String = "https://ugl-consumables.herokuapp.com/api"
  
  private var token: String?
  
  init() {
    token = UserDefaults.standard.value(forKey: "token") as? String
  }
  
  /// GET request to return all the Area of Works
  /// Request requires Authorization Header with a valid token
  func list() async throws -> [AreaOfWorkDto] {
    
    guard let url = URL(string: "\(domain)/areaOfWork"), let token = token else {
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
  
  /// POST request to create an area of work
  /// Request requires Authorization Header with a valid token
  func create(with areaOfWorkFormValues: AreaOfWorkFormValues) async throws -> Bool {
    guard let url = URL(string: "\(domain)/AreaOfWork"), let token = token else {
      throw APIError.invalidURL
    }
    
    // build the request
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    let dataToSend = try? JSONEncoder().encode(areaOfWorkFormValues)
    
    do {
      let (_, response) = try await URLSession.shared.upload(for: request, from: dataToSend!)
            
      guard let httpResponse = response as? HTTPURLResponse else {
        throw APIError.invalidResponseStatus
      }
      
      guard httpResponse.statusCode == 200 else {
        
        if httpResponse.statusCode == 401 {
          throw APIError.unauthorised
        }
        throw APIError.invalidResponseStatus
      }
      
      return true
      
    } catch {
      throw APIError.dataTaskError(error.localizedDescription)
    }
  }
}
