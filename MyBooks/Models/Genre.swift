//
//  Genre.swift
//  MyBooks
//
//  Created by Tim Mitra on 2023-12-03.
//

import SwiftUI
import SwiftData

@Model
class genre {
  var name: String
  var color: String
  
  init(name: String, color: String) {
    self.name = name
    self.color = color
  }
  
  var hexColor: Color {
    Color(hex: self.color) ?? .red
  }
}
