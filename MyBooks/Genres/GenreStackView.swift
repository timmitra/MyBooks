//
//  GenreStackView.swift
//  MyBooks
//
//  Created by Tim Mitra on 2023-12-03.
//

import SwiftUI

struct GenreStackView: View {
  var genres: [Genre]
    var body: some View {
      HStack {
        ForEach(genres.sorted(using: KeyPathComparator(\Genre.name))) { genre in
          Text(genre.name)
            .font(.caption)
            .foregroundColor(.white)
            .padding(5)
            .background(RoundedRectangle(cornerRadius: 5).fill(genre.hexColor))
        }
      }
    }
}

//#Preview {
//    GenreStackView()
//}
