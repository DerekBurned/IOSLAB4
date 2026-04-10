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
        // TODO: resolve FileManager.default Documents directory
        //       and append `filename`.
        URL(fileURLWithPath: "")
    }

    func load() throws -> [ContactData] {
        // TODO: if file doesn't exist → return []
        // TODO: read Data from fileURL
        // TODO: decode with PropertyListDecoder into [ContactData]
        []
    }

    func save(_ contacts: [ContactData]) throws {
        // TODO: encode contacts with PropertyListEncoder
        // TODO: write Data to fileURL atomically
    }
}
