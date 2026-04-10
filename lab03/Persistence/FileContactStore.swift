//
//  FileContactStore.swift
//  lab03
//
//  File-backed implementation of ContactStore using archiving
//  (PropertyListEncoder → Documents/contacts.plist).
//

import Foundation

/// Default `ContactStore` implementation.
///
/// Archives contacts to a property-list file inside the app's
/// Documents directory. This is the modern Swift equivalent of
/// the classic `NSKeyedArchiver` flow required by the lab brief.
final class FileContactStore: ContactStore {

    /// Filename used for the archive inside the Documents directory.
    private let filename: String

    init(filename: String = "contacts.plist") {
        self.filename = filename
    }

    /// Full URL of the archive file (`…/Documents/contacts.plist`).
    private var fileURL: URL {
        URL.documentsDirectory.appending(path: filename)
    }


    func load() throws -> [ContactData] {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return []
        }
        let data = try Data(contentsOf: fileURL)
        return try PropertyListDecoder().decode([ContactData].self, from: data)
    }

    func save(_ contacts: [ContactData]) throws {
        // TODO: encode contacts with PropertyListEncoder
        // TODO: write Data to fileURL atomically
        let encoder = PropertyListEncoder()
            encoder.outputFormat = .xml  // optional: human-readable for debugging
            let data = try encoder.encode(contacts)
            try data.write(to: fileURL, options: .atomic)
    }
}

