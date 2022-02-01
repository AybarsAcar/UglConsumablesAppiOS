//
//  ServiceOrderDetailedView.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 1/2/2022.
//

import SwiftUI


struct ServiceOrderDetailedView: View {
  
  @StateObject private var viewModel: ServiceOrderDetailedViewModel
  
  init(sapId: Int) {
    _viewModel = StateObject.init(wrappedValue: ServiceOrderDetailedViewModel(sapId: sapId))
  }
  
  var body: some View {
    
    List {
      ForEach(viewModel.consumables) { item in
        Text(item.description)
      }
    }
    .listStyle(.plain)
  }
}



struct ServiceOrderDetailedView_Previews: PreviewProvider {
  static var previews: some View {
    ServiceOrderDetailedView(sapId: 6000)
  }
}
