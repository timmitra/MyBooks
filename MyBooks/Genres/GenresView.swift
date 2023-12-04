//
//  GenresView.swift
//  MyBooks
//
//  Created by Tim Mitra on 2023-12-03.
//

import SwiftUI
import SwiftData

struct GenresView: View {
  @Environment(\.dismiss) private var dismiss
  @Environment(\.modelContext) private var context
  @Bindable var book: Book // be able to update properties
  @Query(sort: \Genre.name) var genres: [Genre]
  @State private var newGenre = false
  
  var body: some View {
    NavigationStack {
      Group {
        if genres.isEmpty {
          ContentUnavailableView {
            Image(systemName: "bookmark.fill")
          } description: {
            Text("You need to create some genres.")
          } actions: {
            Button("Create Genre") {
              newGenre.toggle()
            }
            .buttonStyle(.borderedProminent)
          }
        } else {
          List {
            ForEach(genres) { genre in
              HStack {
                if let bookGenres = book.genres {
                  if bookGenres.isEmpty {
                    Button {
                      addRemove(genre)
                    } label: {
                      Image(systemName: "circle")
                    }
                    .foregroundColor(genre.hexColor)
                  } else {
                    Button {
                      addRemove(genre)
                    } label: {
                      Image(systemName: bookGenres.contains(genre) ? "circle.fill" : "circle" )
                    }
                    .foregroundColor(genre.hexColor)
                  }
                }
                Text(genre.name)
              }
            }
            .onDelete(perform: { indexSet in
              indexSet .forEach { index in
                context.delete(genres[index])
              }
            })
            LabeledContent {
              Button {
                newGenre.toggle()
              } label: {
                Image(systemName: "plus.circle.fill")
                  .imageScale(.large)
              }
              .buttonStyle(.borderedProminent)
            } label: {
              Text("Create new genre")
                .font(.caption)
                .foregroundStyle(.secondary)
            }
          }
        }
      }
      .navigationTitle(book.title)
      .sheet(isPresented: $newGenre) {
        NewGenreView()
      }
      .toolbar{
        ToolbarItem(placement: .topBarLeading) {
          Button("Back") {
            dismiss()
          }
        }
      }
    }
  }
  func addRemove(_ genre: Genre) {
    if let bookGenres = book.genres {
      if bookGenres.isEmpty {
        book.genres?.append(genre)
      } else {
        if bookGenres.contains(genre),
           let index = bookGenres.firstIndex(where: {
             $0.id == genre.id
           }) {
          book.genres?.remove(at: index)
        } else {
          book.genres?.append(genre)
        }
        }
      }
    }
  }


#Preview {
  let preview = Preview(Book.self)
  let books = Book.sampleBooks
  let genres = Genre.sampleGenres
   // add examples into preview provider
  preview.addExamples(books)
  preview.addExamples(genres)
  // append a genre
  books[1].genres?.append(genres[0])
  return GenresView(book: books[1])
    .modelContainer(preview.container)
  // using preview container for modelContainer
}
