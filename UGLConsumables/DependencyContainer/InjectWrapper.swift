//
//  InjectWrapper.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 14/5/2022.
//

import Foundation
import Swinject

final class Resolver {
  static let shared = Resolver()
  
  private var container = buildContainer()
  
  func resolve<T>(_ type: T.Type) -> T {
    container.resolve(T.self)!
  }
}

@propertyWrapper
struct Inject<T> {
  let wrappedValue: T
  
  init() {
    // resolve the interface to an implementation
    self.wrappedValue = Resolver.shared.resolve(T.self)
  }
}

func buildContainer() -> Container {
  let container = Container()
  
  container.register(UserRepository.self) { _  in
    return UserService()
  }
  .inObjectScope(.container)
  
  container.register(UserDataLocalRepository.self) { _ in
    return UserDataService()
  }
  .inObjectScope(.container)
  
  container.register(ConsumableRepository.self) { _ in
    return ConsumableService()
  }
  .inObjectScope(.container)
  
  container.register(AreaOfWorkRepository.self) { _ in
    return AreaOfWorkService()
  }
  .inObjectScope(.container)
  
  return container
}

