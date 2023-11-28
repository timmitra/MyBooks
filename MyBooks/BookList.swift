//
//  BookList.swift
//  MyBooks
//
//  Created by Tim Mitra on 2023-11-28.
//

import SwiftUI
import SwiftData

struct BookList: View {
  @Environment(\.modelContext) private var context
  @Query(sort: \Book.author) private var books: [Book]
  
    var body: some View {
      Group {
        if books.isEmpty {
          ContentUnavailableView("Enter your first book", systemImage: "book.fill")
        } else {
          List {
            ForEach(books) { book in
              NavigationLink{
                EditBookView(book: book)
              } label: {
                HStack(spacing: 10){
                  book.icon
                  VStack (alignment: .leading) {
                    Text(book.title).font(.title2)
                    Text(book.author).foregroundStyle(.secondary)
                    if let rating = book.rating {
                      HStack {
                        ForEach(1..<rating, id: \.self) { _ in
                          Image(systemName: "star.fill").imageScale(.small)
                            .foregroundColor(.yellow)
                        }
                      }
                    }
                  }
                }
              }
            }
            .onDelete { indexSet in
              indexSet.forEach { index in
                let book = books[index]
                context.delete(book)
              }
            }
          }
          .listStyle(.plain)
        }
      }
    }
}

#Preview {
  let preview = Preview(Book.self)
  preview.addExamples(Book.sampleBooks)
   return BookList()
    .modelContainer(preview.container)
}
