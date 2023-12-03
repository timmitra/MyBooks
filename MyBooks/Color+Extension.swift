//
//  Color+Extension.swift
//  MyBooks
//
//  Created by Tim Mitra on 2023-12-03.
//

import SwiftUI

extension Color {
  
  init?(hex: String) {
    guard let uiColor = UIColor(hex: hex) else { return nil }
    self.init(uiColor: uiColor)
  }
  
  func toHexString(includeAlpha: Bool = false) -> String? {
    return UIColor(self).toHexString(includeAlpha: includeAlpha)
  }
}
