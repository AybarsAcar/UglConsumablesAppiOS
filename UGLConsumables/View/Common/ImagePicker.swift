//
//  ImagePicker.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 15/4/2022.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
  
  @Binding var image: UIImage?
  @Binding var sourceType: UIImagePickerController.SourceType
  
  init(image: Binding<UIImage?>, sourceType: Binding<UIImagePickerController.SourceType> = .constant(.photoLibrary)) {
    self._image = image
    self._sourceType = sourceType
  }
  
  @Environment(\.dismiss) private var dismiss
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(self)
  }
  
  func makeUIViewController(context: Context) -> some UIImagePickerController {
    let vc = UIImagePickerController()
    vc.delegate = context.coordinator
    vc.sourceType = sourceType
    vc.allowsEditing = true
    return vc
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    
  }
}

// MARK: - Coordinator
extension ImagePicker {
  final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let parent: ImagePicker
    
    init(_ parent: ImagePicker) {
      self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      guard let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage else {
        return
      }
      
      parent.image = image
      
      parent.dismiss()
    }
  }
}
