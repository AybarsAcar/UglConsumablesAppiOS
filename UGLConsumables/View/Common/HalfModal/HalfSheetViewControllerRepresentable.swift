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
  let onDismiss: () -> Void
  
  let controller = UIViewController()
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(parent: self)
  }
  
  func makeUIViewController(context: Context) -> some UIViewController {
    controller.view.backgroundColor = .clear
    
    return controller
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    
    if showSheet {
      // present the modal

      let sheetController = CustomHostingController(rootView: sheetView)
      
      sheetController.presentationController?.delegate = context.coordinator
      
      uiViewController.present(sheetController, animated: true)
    }
    else {
      // closing view when showSheet toggled again
      uiViewController.dismiss(animated: true)
    }
  }
  
  // On dismiss
  class Coordinator: NSObject, UISheetPresentationControllerDelegate {
    
    var parent: HalfSheetHelper
    
    init(parent: HalfSheetHelper) {
      self.parent = parent
    }
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
      parent.showSheet = false
      parent.onDismiss()
    }
  }
}


// MARK: - Custom UIHostingController for halfSheet

class CustomHostingController<Content: View>: UIHostingController<Content> {
  
  var sheetSize: UISheetPresentationController.Detent.Identifier?
  
  override func viewDidLoad() {
    
    // so we can override the background with custom colors and materials from SwiftUI
    // from within the viewbuilder
    view.backgroundColor = .clear
    
    if let presentationController = sheetPresentationController {
      
      presentationController.detents = [.medium(), .large()]
      
      // prevent scrolling from expanding the sheet
      presentationController.prefersScrollingExpandsWhenScrolledToEdge = false
      
      sheetSize = presentationController.selectedDetentIdentifier
      
      // create grabber bar
      presentationController.prefersGrabberVisible = true
    }
  }
}

// MARK: - View Extension

extension View {
  func halfSheet<SheetView: View>(isPresented: Binding<Bool>, @ViewBuilder sheetView: @escaping () -> SheetView, onDismiss: @escaping () -> Void = {}) -> some View {
    return self
      .background(
        HalfSheetHelper(sheetView: sheetView(), showSheet: isPresented, onDismiss: onDismiss)
      )
  }
}
