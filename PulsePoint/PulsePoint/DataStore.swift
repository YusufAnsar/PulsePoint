//
//  DataStore.swift
//  PulsePoint
//
//  Created by Yusuf Ansar on 18/11/24.
//

import Foundation

/// Protocol defining the requirements for a generic data store.
protocol DataStore: Actor {
    associatedtype T
    func save(_ item: T)
    func load() -> T?
}

/// An actor-based data store implementation using property lists for persistence.
/// - Requires: `T` must conform to `Codable` and `Equatable`.
actor PlistDataStore<T: Codable & Equatable>: DataStore {

    // MARK: - Properties

    private var savedItem: T?
    private let filename: String

    private var dataURL: URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("\(filename).plist")
    }

    // MARK: - Initializer

    /// Initializes a new instance of `PlistDataStore`.
    /// - Parameter filename: The name of the file (without extension) to use for storage.
    init(filename: String) {
        self.filename = filename
    }

    // MARK: - Methods

    /// Saves the provided item to the property list file.
    /// - Parameter item: The item to save.
    func save(_ item: T) {
        guard savedItem != item else { return } // Avoid redundant saves.

        do {
            let data = try PropertyListEncoder().encode(item)
            try data.write(to: dataURL, options: .atomic)
            savedItem = item
        } catch {
            print("Save error: \(error.localizedDescription)")
        }
    }

    /// Loads the item from the property list file.
    /// - Returns: The loaded item, or `nil` if an error occurs.
    func load() -> T? {
        do {
            let data = try Data(contentsOf: dataURL)
            let decodedItem = try PropertyListDecoder().decode(T.self, from: data)
            savedItem = decodedItem
            return decodedItem
        } catch {
            print("Load error: \(error.localizedDescription)")
            return nil
        }
    }
}
