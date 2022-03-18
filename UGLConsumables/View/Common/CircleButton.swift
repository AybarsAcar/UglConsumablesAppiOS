//
//  CircleButton.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 24/2/2022.
//

import SwiftUI

/// TODO: Finish component
struct CircleButton: View {
  
  @State private var tap = false
  @State private var press = false
  
  var body: some View {
    ZStack {
      Image(systemName: "sun.max")
        .font(.system(size: 44, weight: .light))
        .offset(x: press ? -90 : 0, y: press ? 90 : 0)
        .rotation3DEffect(Angle(degrees: press ? 20 : 0), axis: (x: 0, y: 0, z: 0))
      
      Image(systemName: "moon")
        .font(.system(size: 44, weight: .light))
        .offset(x: press ? 0 : 90, y: press ? 0 : 90)
        .rotation3DEffect(Angle(degrees: press ? 0 : 20), axis: (x: 0, y: 0, z: 0))
    }
    .frame(width: 100, height: 100)
    .background(
      
    )
  }
}



struct CircleButton_Previews: PreviewProvider {
  static var previews: some View {
    CircleButton()
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
