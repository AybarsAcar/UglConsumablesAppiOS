//
//  SlidingTabView.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 24/1/2022.
//

import SwiftUI


struct SlidingTabView<Content>: View where Content: View {
  
  @State private var selectionState: Int = 0 {
    didSet {
      selection = selectionState
    }
  }
  
  @Binding var selection: Int
  
  let tabTitles: [String]
  
  // The font of the tab title
  let font: Font
  
  // The selection bar sliding animation type
  let animation: Animation
  
  // The accent color when the tab is selected
  let activeAccentColor: Color
  
  // The accent color when the tab is not selected
  let inactiveAccentColor: Color
  
  // The color of the selection bar
  let selectionBarColor: Color
  
  // The tab color when the tab is not selected
  let inactiveTabColor: Color
  
  // The tab color when the tab is  selected
  let activeTabColor: Color
  
  // The height of the selection bar
  let selectionBarHeight: CGFloat
  
  // The selection bar background color
  let selectionBarBackgroundColor: Color
  
  // The height of the selection bar background
  let selectionBarBackgroundHeight: CGFloat
  
  let content: Content
  
  
  init(
    selection: Binding<Int>,
    tabTitles: [String],
    font: Font = .body,
    animation: Animation = .spring(),
    activeAccentColor: Color = .blue,
    inactiveAccentColor: Color = Color.black.opacity(0.4),
    selectionBarColor: Color = .blue,
    inactiveTabColor: Color = .clear,
    activeTabColor: Color = .clear,
    selectionBarHeight: CGFloat = 2,
    selectionBarBackgroundColor: Color = Color.gray.opacity(0.2),
    selectionBarBackgroundHeight: CGFloat = 1,
    @ViewBuilder content: () -> Content
  ) {
    self._selection = selection
    self.tabTitles = tabTitles
    self.font = font
    self.animation = animation
    self.activeAccentColor = activeAccentColor
    self.inactiveAccentColor = inactiveAccentColor
    self.selectionBarColor = selectionBarColor
    self.inactiveTabColor = inactiveTabColor
    self.activeTabColor = activeTabColor
    self.selectionBarHeight = selectionBarHeight
    self.selectionBarBackgroundColor = selectionBarBackgroundColor
    self.selectionBarBackgroundHeight = selectionBarBackgroundHeight
    self.content = content()
  }
  
  
  var body: some View {
    
    VStack(spacing: 0) {
      VStack(alignment: .leading, spacing: 0) {
        HStack(spacing: 0) {
          ForEach(self.tabTitles, id:\.self) { tab in
            Button(action: {
              let selection = self.tabTitles.firstIndex(of: tab) ?? 0
              self.selectionState = selection
            }) {
              HStack {
                Spacer()
                Text(tab).font(self.font)
                Spacer()
              }
            }
            .padding(.vertical, 16)
            .accentColor(
              self.isSelected(tabIdentifier: tab)
              ? self.activeAccentColor
              : self.inactiveAccentColor)
            .background(
              self.isSelected(tabIdentifier: tab)
              ? self.activeTabColor
              : self.inactiveTabColor)
          }
        }
        GeometryReader { geometry in
          ZStack(alignment: .leading) {
            Rectangle()
              .fill(self.selectionBarColor)
              .frame(width: self.tabWidth(from: geometry.size.width), height: self.selectionBarHeight, alignment: .leading)
              .offset(x: self.selectionBarXOffset(from: geometry.size.width), y: 0)
              .animation(self.animation)
            Rectangle()
              .fill(self.selectionBarBackgroundColor)
              .frame(width: geometry.size.width, height: self.selectionBarBackgroundHeight, alignment: .leading)
          }.fixedSize(horizontal: false, vertical: true)
        }.fixedSize(horizontal: false, vertical: true)
      }
      
      content
    }
  }
  
  private func isSelected(tabIdentifier: String) -> Bool {
    return tabTitles[selectionState] == tabIdentifier
  }
  
  private func selectionBarXOffset(from totalWidth: CGFloat) -> CGFloat {
    return self.tabWidth(from: totalWidth) * CGFloat(selectionState)
  }
  
  private func tabWidth(from totalWidth: CGFloat) -> CGFloat {
    return totalWidth / CGFloat(tabTitles.count)
  }
}



//struct SlidingTabView_Previews: PreviewProvider {
//  static var previews: some View {
//    SlidingTabView()
//  }
//}
