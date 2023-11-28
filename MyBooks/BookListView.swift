//
//  ContentView.swift
//  MyBooks
//
//  Created by Tim Mitra on 2023-11-27.
//

import SwiftUI
import SwiftData

struct BookListView: View {
  @Environment(\.modelContext) private var context
  @Query(sort: \Book.author) private var books: [Book]
  @State private var createNewBook = false
    var body: some View {
      NavigationStack {
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
        .navigationTitle("My Books")
        .toolbar {
          Button {
            createNewBook = true // present view
          } label: {
            Image(systemName: "plus.circle.fill")
              .imageScale(.large)
          }
        }
        .sheet(isPresented: $createNewBook) { // training closure
          NewBookView()
            .presentationDetents([.medium])
        }
      }
    }
}

#Preview {
  let preview = Preview(Book.self)
  preview.addExamples(Book.sampleBooks)
   return BookListView()
    .modelContainer(preview.container)
}
