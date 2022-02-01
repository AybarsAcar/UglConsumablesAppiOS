//
//  DrowdownPicker.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 1/2/2022.
//

import SwiftUI


struct DropdownPicker: View {
  
  let title: String
  @Binding var selection: Int
  let options: [String]
  
  @State private var showOptions: Bool = false
  
  var body: some View {
    ZStack {
      HStack {
        Text(title)
        
        Spacer()
        
        Text(options[selection])
          .foregroundColor(Color.black.opacity(0.6))
        
        Image(systemName: "chevron.right")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 10, height: 10)
      }
      .font(Font.custom("Avenir Next", size: 16).weight(.medium))
      .padding(.horizontal, 12)
      .padding(.vertical, 8)
      .background(Color.white)
      .onTapGesture {
        // show the dropdown options
        withAnimation(Animation.spring().speed(2)) {
          showOptions = true
        }
      }
      
      if showOptions {
        VStack(alignment: .leading, spacing: 4) {
          Text(title)
            .font(Font.custom("Avenir Next", size: 16).weight(.semibold))
            .foregroundColor(.white)
          HStack {
            // options here
            Spacer()
            ForEach(options.indices, id: \.self) { i in
              if i == selection {
                Text(options[i])
                  .font(.system(size: 12))
                  .padding(.vertical, 8)
                  .padding(.horizontal, 12)
                  .background(Color.white.opacity(0.2))
                  .cornerRadius(4)
              } else {
                Text(options[i])
                  .font(.system(size: 12))
              }
              Spacer()
            }
          }
          .padding(.vertical, 2)
          .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
        }
      }
    }
  }
}



struct DrowdownPicker_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      DropdownPicker(title: "Picker", selection: .constant(1), options: ["EA", "M", "BOX"])
      
      DropdownPicker(title: "Picker", selection: .constant(1), options: ["EA", "M", "BOX"])
        .preferredColorScheme(.dark)
    }
    .previewLayout(.sizeThatFits)
    .padding()
  }
}
