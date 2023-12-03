//
//  QuoteListView.swift
//  MyBooks
//
//  Created by Tim Mitra on 2023-11-28.
//

import SwiftUI

struct QuoteListView: View {
  @Environment(\.modelContext) private var modelContext
  let book: Book
  @State private var text = ""
  @State private var page = ""
  @State private var selectedQuote: Quote?
  var isEditing: Bool {
    selectedQuote != nil
  }

    var body: some View {
      GroupBox {
        HStack {
          LabeledContent("Page") {
            TextField("page #", text: $page)
              .autocorrectionDisabled()
              .textFieldStyle(.roundedBorder)
              .frame(width: 150)
            Spacer()
          }
          if isEditing {
            Button("Cancel") {
              page = ""
              text = ""
              selectedQuote = nil
            }
          }
          Button(isEditing ? "Update" : "Create") {
            if isEditing {
              selectedQuote?.text = text
              selectedQuote?.page = page.isEmpty ? nil : page
              page = ""
              text = ""
              selectedQuote = nil
            } else {
              let quote = page.isEmpty ? Quote(text: text) : Quote(text: text, page: page)
              book.quotes?.append(quote)
              text = ""
              page = ""
            }
          }
          .buttonStyle(.borderedProminent)
          .disabled(text.isEmpty)
        }
        TextEditor(text: $text)
          .border(Color.secondary)
          .frame(height: 100)
      }
      .padding(.horizontal)
      List {
        //* assign empty array since sortedQuotes is Optional
        //* so now this creationDate is no longer Optional *//
        let sortedQuotes = book.quotes?.sorted(using: KeyPathComparator(\Quote.creationDate)) ?? []
        ForEach(sortedQuotes) { quote in
          VStack(alignment: .leading) {
            Text(quote.creationDate, format: .dateTime.month().day().year())
              .font(.caption)
              .foregroundStyle(.secondary)
            Text(quote.text)
            HStack {
              Spacer()
              if let page = quote.page, !page.isEmpty {
                Text("Page:  \(page)")
              }
            }
          }
          .contentShape(Rectangle())
          .onTapGesture {
            selectedQuote = quote
            text = quote.text
            page = quote.page ?? ""
          }
        }
        // on Foreach
        .onDelete { indexSet in
          withAnimation {
            indexSet.forEach { index in
              let quote = sortedQuotes[index]
              book.quotes?.forEach { bookQuote in
                if quote.id == bookQuote.id {
                  modelContext.delete(quote)
                }
              }
            }
          }
        }
      }
      .listStyle(.plain)
      .navigationTitle("Quotes")
    }
}

#Preview {
  let preview = Preview(Book.self)
  let books = Book.sampleBooks
  preview.addExamples(books)
  return NavigationStack {
    QuoteListView(book: books[4])
      .navigationBarTitleDisplayMode(.inline) // as it will be nested
        .modelContainer(preview.container)
  }
}
