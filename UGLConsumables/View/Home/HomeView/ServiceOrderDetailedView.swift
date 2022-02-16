//
//  ServiceOrderDetailedView.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 1/2/2022.
//

import SwiftUI


struct ServiceOrderDetailedView: View {
  
  @StateObject private var viewModel: ServiceOrderDetailedViewModel
  let areaOfWork: AreaOfWorkDto
  
  init(areaOfWork: AreaOfWorkDto) {
    self.areaOfWork = areaOfWork
    self._viewModel = StateObject.init(wrappedValue: ServiceOrderDetailedViewModel(sapId: areaOfWork.serviceOrder))
  }
  
  var body: some View {
    
    List {
      ForEach(viewModel.consumables) { item in
        Text(item.description)
      }
    }
    .listStyle(.plain)
    .navigationTitle(areaOfWork.description)
    .overlay(alignment: .center) {
      if viewModel.isLoading {
        ProgressView()
      }
    }
  }
}



struct ServiceOrderDetailedView_Previews: PreviewProvider {
  static var previews: some View {
    ServiceOrderDetailedView(areaOfWork: AreaOfWorkDto(id: 1, description: "Area of Work", serviceOrder: 6000))
  }
}
