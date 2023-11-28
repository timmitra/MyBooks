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
  let container: ModelContainer
    var body: some Scene {
        WindowGroup {
            BookListView()
        }
        .modelContainer(container) // the model type to store
    }
  
  init() {
    let schema = Schema([Book.self]) // Quote already gets connected
    let config = ModelConfiguration("MyBooks", schema: schema)
    do {
      container = try ModelContainer(for: schema, configurations: config)
    } catch {
      fatalError("Could not configure the container")
    }
//    let config = ModelConfiguration(url: URL.documentsDirectory.appending(path: "MyBooks.store"))
//    do {
//      container = try ModelContainer(for: Book.self, configurations: config)
//    } catch {
//      fatalError("Could not configure the container")
//    }
    print(URL.applicationSupportDirectory.path(percentEncoded: false))
    //print(URL.documentsDirectory.path())
  }
}
