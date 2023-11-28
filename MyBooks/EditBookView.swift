//
//  EditBookView.swift
//  MyBooks
//
//  Created by Tim Mitra on 2023-11-27.
//

import SwiftUI

struct EditBookView: View {
  @Environment(\.dismiss) var dismiss
  let book: Book
  @State private var title = ""
  @State private var author = ""
  @State private var dateAdded = Date.distantPast
  @State private var dateStarted = Date.distantPast
  @State private var dateCompleted = Date.distantPast
  @State private var synopsis = ""
  @State private var rating: Int?
  @State private var status = Status.onShelf
  @State private var firstView = true
  @State private var recommendedBy = ""
  
    var body: some View {
      HStack {
        Text("Status")
        Picker("Status", selection: $status) {
          ForEach(Status.allCases) { status in
            Text(status.descr).tag(status)
          }
        }
        .buttonStyle(.bordered)
      }
      VStack(alignment: .leading) {
        GroupBox {
          LabeledContent {
            DatePicker("", selection: $dateAdded, displayedComponents: .date)
          } label: {
            Text("Date Added")
          }
          if status == .inProgress || status == .completed {
            LabeledContent {
              DatePicker("", selection: $dateStarted, in: dateAdded..., displayedComponents: .date)
            } label: {
              Text("Date Started")
            }
          }
          if status == .completed {
            LabeledContent {
              DatePicker("", selection: $dateCompleted, in: dateStarted..., displayedComponents: .date)
            } label: {
              Text("Date Campleted")
            }
          }
        }
        .foregroundStyle(.secondary)
        .onChange(of: status) { oldValue, newValue in
          if !firstView {
            if newValue == .onShelf {
              dateStarted = Date.distantPast
              dateCompleted = Date.distantPast
            } else if newValue == .inProgress && oldValue == .completed {
              // from completed to inProgress
              dateCompleted = Date.distantPast
            } else if newValue == .inProgress && oldValue == .onShelf {
              // started the book
              dateStarted = Date.now
            } else if newValue == .completed && oldValue == .onShelf {
              // forgot to start book
              dateCompleted = Date.now
              dateStarted = dateAdded
            } else {
              // completed
              dateCompleted = Date.now
            }
            firstView = false
          }
        }
        Divider()
        LabeledContent {
          RatingsView(maxRating: 5, currentRating: $rating, width: 30)
        } label: {
          Text("Rating")
        }
        LabeledContent {
          TextField("", text: $title)
        } label: {
          Text("Title").foregroundStyle(.secondary)
        }
        LabeledContent {
          TextField("", text: $author)
        } label: {
          Text("Author").foregroundStyle(.secondary)
        }
        LabeledContent {
          TextField("", text: $recommendedBy)
        } label: {
          Text("Recommended By").foregroundStyle(.secondary)
        }
        Divider()
        Text("Synopsis").foregroundStyle(.secondary)
        TextEditor(text: $synopsis)
          .padding(5)
          .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color (uiColor: .tertiarySystemFill), lineWidth: 2))
      }
      .padding()
      .textFieldStyle(.roundedBorder)
      .navigationTitle(title)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        if changed {
          Button("Update") {
            book.title = title
            book.author = author
            book.rating = rating
            book.status = status.rawValue
            book.dateAdded = dateAdded
            book.dateStarted = dateStarted
            book.dateAdded = dateAdded
            book.dateCompleted = dateCompleted
            book.synopsis = synopsis
            book.recommendedBy = recommendedBy
            dismiss()
          }
          .buttonStyle(.borderedProminent)
        }
      }
      .onAppear {
        title = book.title
        author = book.author
        rating = book.rating
        status = Status(rawValue: book.status)!
        synopsis = book.synopsis
        dateAdded = book.dateAdded
        dateStarted = book.dateStarted
        dateCompleted = book.dateCompleted
        recommendedBy = book.recommendedBy
      }
      
      // check if any values are changed
      var changed: Bool {
        title != book.title
        || 	author != book.author
        || 	rating != book.rating
        || 	status != Status(rawValue: book.status)!
        || 	synopsis != book.synopsis
        || 	dateAdded != book.dateAdded
        || 	dateStarted != book.dateStarted
        || 	dateCompleted != book.dateCompleted
        || recommendedBy != book.recommendedBy
      }
    }
}

#Preview {
  let preview = Preview(Book.self)
  return NavigationStack {
    EditBookView(book: Book.sampleBooks[4])
      .modelContainer(preview.container)
  }
}
