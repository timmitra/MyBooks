//
//  MyBooksApp.swift
//  MyBooks
//
//  Created by Tim Mitra on 2023-11-27.
//

import SwiftUI
import SwiftData

@main
struct MyBooksApp: App {
    var body: some Scene {
        WindowGroup {
            BookListView()
        }
        .modelContainer(for: Book.self) // the model type to store
    }
  
  init() {
    print(URL.applicationSupportDirectory.path(percentEncoded: false))
  }
}
