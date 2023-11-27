//
//  ContentView.swift
//  MyBooks
//
//  Created by Tim Mitra on 2023-11-27.
//

import SwiftUI

struct BookListView: View {
  @State private var createNewBook = false
    var body: some View {
      NavigationStack {
        VStack {
          Image(systemName: "globe")
            .imageScale(.large)
            .foregroundStyle(.tint)
          Text("Hello, world!")
        }
        .padding()
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
    BookListView()
}
