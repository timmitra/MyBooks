//
//  GenreSamples.swift
//  MyBooks
//
//  Created by Tim Mitra on 2023-12-03.
//

import Foundation

extension Genre {
  static var sampleGenres: [Genre] {
    [
    Genre(name: "Fiction", color: "00FF00"),
    Genre(name: "Non-fiction", color: "0000FF"),
    Genre(name: "Romantic", color: "FF0000"),
    Genre(name: "Thriller", color: "000000")
    ]
  }
}
