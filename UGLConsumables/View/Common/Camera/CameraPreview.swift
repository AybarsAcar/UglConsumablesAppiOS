//
//  CameraPreview.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 29/1/2022.
//

import Foundation
import SwiftUI
import AVFoundation


struct CameraPreview: UIViewRepresentable {

  @ObservedObject var camera: CameraModel

  func makeUIView(context: Context) -> some UIView {
    let view = UIView(frame: UIScreen.main.bounds)
    
    camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
    camera.preview.frame = view.frame
    
    // configure properties here...
    
    camera.preview.videoGravity = .resizeAspectFill
    
    view.layer.addSublayer(camera.preview)
    
    // starting session
    camera.session.startRunning()
    
    return view
  }
  
  func updateUIView(_ uiView: UIViewType, context: Context) {
    
  }
}
