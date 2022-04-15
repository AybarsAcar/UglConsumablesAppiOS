//
//  HalfSheetViewControllerRepresentable.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 15/4/2022.
//

import SwiftUI

struct  HalfSheetHelper<SheetView: View>: UIViewControllerRepresentable {
  
  var sheetView: SheetView
  @Binding var showSheet: Bool
  
  let controller = UIViewController()
  
  func makeUIViewController(context: Context) -> some UIViewController {
    controller.view.backgroundColor = .clear
    
    return controller
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    
    if showSheet {
      // present the modal

      let sheetController = CustomHostingController(rootView: sheetView)
      
      uiViewController.present(sheetController, animated: true) {
        // toggling show state on dismiss
        DispatchQueue.main.async {
          self.showSheet.toggle()
        }
      }
    }
  }
}


// MARK: - Custom UIHostingController for halfSheet

class CustomHostingController<Content: View>: UIHostingController<Content> {
  
  override func viewDidLoad() {
    if let presentationController = presentationController as? UISheetPresentationController {
      
      presentationController.detents = [.medium(), .large()]
      
      // create grabber bar
      presentationController.prefersGrabberVisible = true
    }
  }
}

// MARK: - View Extension

extension View {
  func halfSheet<SheetView: View>(isPresented: Binding<Bool>, @ViewBuilder sheetView: @escaping () -> SheetView) -> some View {
    return self
      .background(
        HalfSheetHelper(sheetView: sheetView(), showSheet: isPresented)
      )
  }
}
