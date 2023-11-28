//
//  ContentView.swift
//  MyBooks
//
//  Created by Tim Mitra on 2023-11-27.
//

import SwiftUI
import SwiftData

enum SortOrder: String, Identifiable, CaseIterable {
  case title, author, status
  var id: Self {
    self
  }
}

struct BookListView: View {

  @State private var createNewBook = false
  @State private var sortOrder = SortOrder.status
  @State private var filter = ""
    var body: some View {
      NavigationStack {
        Picker("", selection: $sortOrder) {
          ForEach(SortOrder.allCases) { sortOrder in
            Text("Sort By: \(sortOrder.rawValue)").tag(sortOrder)
          }
        }.buttonStyle(.bordered)
        BookList(sortOrder: sortOrder, filterString: filter)
          .searchable(text: $filter, prompt: Text("Filter on title or author"))
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
