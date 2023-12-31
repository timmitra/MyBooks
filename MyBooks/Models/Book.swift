//
//  Book.swift
//  MyBooks
//
//  Created by Tim Mitra on 2023-11-27.
//

import SwiftUI
import SwiftData

@Model
class Book {
  var title: String = ""
  var author: String = ""
  var dateAdded: Date = Date.now
  var dateStarted: Date = Date.distantPast
  var dateCompleted: Date = Date.distantPast
  @Attribute(originalName: "summary")
  var synopsis: String = ""
  var rating: Int?
  var status: Status.RawValue = Status.onShelf.rawValue
  var recommendedBy: String = ""
  /* @Relationship makes the quotes relationship explicit */
  /* needs to be Optional for iCloud later */
  @Relationship(deleteRule: .cascade)
  var quotes: [Quote]?
  /* be explicit about the inverse relationship (with default nullify for delete)*/
  @Relationship(inverse: \Genre.books)
  var genres: [Genre]?
  @Attribute(.externalStorage)
  var bookCover: Data?
  
  init(
    title: String,
    author: String,
    dateAdded: Date = Date.now,
    dateStarted: Date = Date.distantPast,
    dateCompleted: Date = Date.distantPast,
    synopsis: String = "",
    rating: Int? = nil,
    status: Status = .onShelf,
    recommendedBy: String = ""
  ) {
    self.title = title
    self.author = author
    self.dateAdded = dateAdded
    self.dateStarted = dateStarted
    self.dateCompleted = dateCompleted
    self.synopsis = synopsis
    self.rating = rating
    self.status = status.rawValue
    self.recommendedBy = recommendedBy
  }
  
  var icon: Image { // computed properties are not stored in DB
    switch Status(rawValue: status)! {
    case .onShelf:
      Image(systemName: "checkmark.diamond.fill")
    case .inProgress:
      Image(systemName: "book.fill")
    case .completed:
      Image(systemName: "books.vertical.fill")
    }
  }
}

enum Status: Int, Codable, Identifiable, CaseIterable {
  case onShelf, inProgress, completed
  var id: Self {
    self // return
  }
  var descr: String {
    switch self {
    case .onShelf:
      "On Shelf"
    case .inProgress:
      "In Progress"
    case .completed:
      "Completed"
    }
  }
}
