//
//  CameraView.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 29/1/2022.
//

import SwiftUI


struct CameraView: View {
  
  @Environment(\.dismiss) private var dismiss
  
  @StateObject private var camera = CameraModel()

  
  var body: some View {
    ZStack {
      // camera preview
      CameraPreview(camera: camera)
        .ignoresSafeArea(.all, edges: .all)
      
      VStack {
        
        HStack(alignment: .center) {
          Button(action: {
            dismiss()
          }) {
            Image(systemName: "arrowshape.turn.up.backward")
              .foregroundColor(.black)
              .padding()
              .background(Color.white)
              .clipShape(Circle())
          }
          .padding(.leading, 10)
          
          Spacer()
          
          if camera.isTaken {
            Button(action: {
              camera.reTakePhoto()
            }) {
              Image(systemName: "arrow.triangle.2.circlepath.camera")
                .foregroundColor(.black)
                .padding()
                .background(Color.white)
                .clipShape(Circle())
            }
            .padding(.trailing, 10)
          }
        }
        
        Spacer()
        
        HStack {
          
          if camera.isTaken {
            
            Button(action: {
              if !camera.isSaved {
                camera.savePhoto()
              }
            }) {
              Text(camera.isSaved ? "Saved!" : "Save")
                .foregroundColor(.black)
                .fontWeight(.semibold)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(Color.white)
                .clipShape(Capsule())
            }
            .padding(.leading)
            
            Spacer()
            
          } else {
            
            Button(action: {
              camera.takePhoto()
            }) {
              
              ZStack {
                Circle()
                  .fill(.white)
                  .frame(width: 65, height: 65)
                
                Circle()
                  .stroke(Color.white, lineWidth: 2)
                  .frame(width: 75, height: 75)
              }
            }
          }
        }
        .frame(height: 75)
      }
    }
    .onAppear {
      camera.check()
    }
  }
}



struct CameraView_Previews: PreviewProvider {
  static var previews: some View {
    CameraView()
  }
}
