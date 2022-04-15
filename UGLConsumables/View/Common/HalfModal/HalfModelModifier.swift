//
//  HalfModelModifier.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 15/4/2022.
//

import SwiftUI

extension View {
  func halfSheet<SheetView: View>(isPresented: Binding<Bool>, @ViewBuilder sheetView: @escaping () -> SheetView) -> some View {
    return self
      .background(
        HalfSheetHelper(sheetView: sheetView(), showSheet: isPresented)
      )
  }
}
