//
//  CameraModel.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 29/1/2022.
//

import Foundation
import AVFoundation
import SwiftUI


class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
  @Published var isTaken: Bool = false
  
  @Published var session = AVCaptureSession()
  
  @Published var alert: Bool = false
  
  // to read pic data
  @Published var output = AVCapturePhotoOutput()
  
  // preview
  @Published var preview = AVCaptureVideoPreviewLayer()
  
  // photo data
  @Published var isSaved: Bool = false
  @Published var photoData = Data(count: 0)
  
  func check() {
    // first checking if camera has permission
    
    switch AVCaptureDevice.authorizationStatus(for: .video) {
    case .authorized:
      // setup session
      setup()
      return
      
    case .notDetermined:
      // requesting permission
      AVCaptureDevice.requestAccess(for: .video) { status in
        if status {
          self.setup()
        }
      }
      
    case .denied:
      self.alert.toggle()
      return
      
    default:
      return
    }
  }
  
  
  func setup() {
    // setting up camera
    
    do {
      // setting configs
      self.session.beginConfiguration()
      
      // make extra configs here...
      
      let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back)
      
      guard let device = device else {
        return
      }
      
      let input = try AVCaptureDeviceInput(device: device)
      
      // checking and adding to session
      if self.session.canAddInput(input) {
        self.session.addInput(input)
      }
      
      // same for output
      if self.session.canAddOutput(self.output) {
        self.session.addOutput(self.output)
      }
      
      self.session.commitConfiguration()
      
    } catch {
      print(error.localizedDescription)
    }
  }
  

  func takePhoto() {
    DispatchQueue.global(qos: .background).async {
      
      self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
      self.session.stopRunning()
      
      DispatchQueue.main.async {
        withAnimation {
          self.isTaken.toggle()
        }
      }
    }
  }
  
  
  func reTakePhoto() {
    DispatchQueue.global(qos: .background).async {
      
      self.session.startRunning()
      
      DispatchQueue.main.async {
        withAnimation {
          self.isTaken.toggle()
          
          // cleanup
          self.isSaved = false
        }
      }
    }
  }
  
  
  func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
    guard error != nil else { return }
    
    print("pic taken...")
    
    guard let imageData = photo.fileDataRepresentation() else { return }
    
    self.photoData = imageData
  }
  
  
  func savePhoto() {
    
    let image = UIImage(data: self.photoData)
    
    // saving image
//    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    
    self.isSaved = true
  }
}
