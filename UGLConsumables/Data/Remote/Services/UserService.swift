//
//  UserService.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 25/1/2022.
//

import Foundation

final class UserService: UserRepository {
  
  private let domain: String = "https://ugl-consumables.herokuapp.com/api"
  
  func login(with loginDetails: LoginAccountDetails) async throws -> AccountDto {
    
    guard let url = URL(string: "\(domain)/Account/login") else {
      throw APIError.invalidURL
    }
    
    // build the request
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let dataToSend = try? JSONEncoder().encode(loginDetails)
    
    do {
      let (data, response) = try await URLSession.shared.upload(for: request, from: dataToSend!)
      
      guard let httpResponse = response as? HTTPURLResponse else {
        throw APIError.invalidResponseStatus
      }
      
      guard httpResponse.statusCode == 200 else {
        
        if httpResponse.statusCode == 401 {
          throw APIError.unauthorised
        }
        throw APIError.invalidResponseStatus
      }
      
      let decoder = JSONDecoder()
      
      do {
        let user = try decoder.decode(AccountDto.self, from: data)
        return user
      } catch {
        throw APIError.decodingError(error.localizedDescription)
      }
      
    } catch {
      throw APIError.dataTaskError(error.localizedDescription)
    }
  }
  
  
  func signUp(with registerDetails: RegisterAccountDetails) async throws -> AccountDto {
    
    guard let url = URL(string: "\(domain)/api/Account/register") else {
      throw APIError.invalidURL
    }
    
    // build the request
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let dataToSend = try? JSONEncoder().encode(registerDetails)
    
    do {
      let (data, response) = try await URLSession.shared.upload(for: request, from: dataToSend!)
      
      guard let httpResponse = response as? HTTPURLResponse else {
        throw APIError.invalidResponseStatus
      }
      
      guard httpResponse.statusCode == 200 else {
        if httpResponse.statusCode == 401 {
          throw APIError.unauthorised
        }
        throw APIError.invalidResponseStatus
      }
      
      let decoder = JSONDecoder()
      
      do {
        print(data)
        let user = try decoder.decode(AccountDto.self, from: data)
        
        return user
        
      } catch {
        throw APIError.decodingError(error.localizedDescription)
      }
      
    } catch {
      throw APIError.dataTaskError(error.localizedDescription)
    }
  }
}

