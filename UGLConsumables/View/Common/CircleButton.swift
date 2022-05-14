//
//  CircleButton.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 24/2/2022.
//

import SwiftUI

/// TODO: Finish component
struct CircleButton: View {
  
  @State private var tapped = false
  @Binding var isLightTheme: Bool
  
  var body: some View {
    
    ZStack {
      Image(systemName: "sun.max")
        .font(.system(size: 44, weight: .light))
        .offset(x: !isLightTheme ? -90 : 0, y: !isLightTheme ? -90 : 0)
        .rotation3DEffect(.degrees(!isLightTheme ? 20 : 0), axis: (10, -10, 0))
      
      Image(systemName: "moon")
        .font(.system(size: 44, weight: .light))
        .offset(x: !isLightTheme ? 0 : 90, y: !isLightTheme ? 0 : 90)
        .rotation3DEffect(.degrees(!isLightTheme ? 0 : 20), axis: (-10, 10, 0))
    }
    .frame(width: 80, height: 80)
    .background(
      ZStack {
        LinearGradient(gradient: Gradient(colors: [Color(!isLightTheme ? #colorLiteral(red: 0.9019607843, green: 0.9294117647, blue: 0.9882352941, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(!isLightTheme ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.9019607843, green: 0.9294117647, blue: 0.9882352941, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
        
        // inner shadows
        Circle()
          .stroke(.black.opacity(0.0000001), lineWidth: 10)
          .shadow(color: Color(#colorLiteral(red: 0.7256438732, green: 0.7787529826, blue: 0.8831245303, alpha: 1)), radius: !isLightTheme ? 10 : 3, x: !isLightTheme ? 5 : -5, y: !isLightTheme ? 5 : -5)
        
        Circle()
          .stroke(.black.opacity(0.0000001), lineWidth: 10)
          .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 3, x: !isLightTheme ? -3 : 3, y: !isLightTheme ? -3 : 3)
        
      }
    )
    .clipShape(Circle())
    .shadow(color: .white, radius: 20, x: -20, y: -20)
    .shadow(color: Color(#colorLiteral(red: 0.7294117647, green: 0.7843137255, blue: 0.8941176471, alpha: 1)), radius: 20, x: 20, y: 20)
    .scaleEffect(tapped ? 1.2 : 1)
    .gesture(
      LongPressGesture(minimumDuration: 0.3)
        .onChanged { value in
          withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0)) {
            tapped = true
          }
          
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0)) {
              tapped = false
            }
          }
        }
        .onEnded { value in
          HapticsManager.shared.impact(withStyle: .soft)
          withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0)) {
            isLightTheme.toggle()
          }
        }
    )
    
  }
}



struct CircleButton_Previews: PreviewProvider {
  static var previews: some View {
    CircleButton(isLightTheme: .constant(true))
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
