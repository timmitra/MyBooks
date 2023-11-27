//
//  PreviewContainer.swift
//  MyBooks
//
//  Created by Tim Mitra on 2023-11-27.
//

import Foundation
import SwiftData

struct Preview {
  let container: ModelContainer
  init() {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    do {
      container = try ModelContainer(for: Book.self, configurations: config)
    } catch {
      fatalError("Could not configure the container")
    }
  }
  func addExamples(_ examples: [Book]) {
    Task { @MainActor in // Task to make async and "@MainActor in" to put it on the main thread
      examples.forEach { example in
        container.mainContext.insert(example)
      }
    }
  }
}
