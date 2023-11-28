//
//  Quote.swift
//  MyBooks
//
//  Created by Tim Mitra on 2023-11-28.
//

import Foundation
import SwiftData

@Model
class Quote {
  var creationDate: Date = Date.now
  var text: String
  var page: String?
  
  // don't need to init Date since it's set to Date.now
  init(text: String, page: String? = nil) {
    self.text = text
    self.page = page
  }
  
  // only one.
  var book: Book?
}
