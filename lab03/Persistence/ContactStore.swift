//
//  ContactStore.swift
//  lab03
//
//  Persistence layer — abstraction over contact archiving.
//

import Foundation

/// Abstraction over contact persistence.
/// Implementations decide *where* and *how* contacts are archived
/// (file, UserDefaults, CoreData, ...). The view model depends only
/// on this protocol, never on a concrete store.
protocol ContactStore {

    /// Load all archived contacts. Returns an empty array on first launch
    /// (when no archive file exists yet).
    func load() throws -> [ContactData]

    /// Persist the full contact list, overwriting the previous archive.
    func save(_ contacts: [ContactData]) throws
}
