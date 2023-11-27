//
//  NewBookView.swift
//  MyBooks
//
//  Created by Tim Mitra on 2023-11-27.
//

import SwiftUI

struct NewBookView: View {
  @Environment(\.modelContext) private var context
  @Environment(\.dismiss) var dismiss
  @State var title = ""
  @State var author = ""
  
  var body: some View {
    NavigationStack {
      Form {
        TextField("Book Title", text: $title)
        TextField("Author", text: $author)
        Button ("Create") {
          let newBook = Book(title: title, author: author)
          context.insert(newBook)
          dismiss()
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .buttonStyle(.borderedProminent)
        .padding(.vertical)
        .disabled(title.isEmpty || author.isEmpty)
        .navigationTitle("New Book")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
          ToolbarItem (placement: .topBarLeading) {
            Button("Cancel") {
              dismiss()
            }
          }
        }
      }
    }
  }
}

#Preview {
  NewBookView()
}
