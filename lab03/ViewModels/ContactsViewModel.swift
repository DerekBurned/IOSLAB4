//
//  ContactsViewModel.swift
//  lab03
//
//  Owns the contact list, exposes CRUD + grouping/sorting,
//  and persists changes through an injected ContactStore.
//

import Foundation

/// Single source of truth for the contact list screen and all its
/// children (form, detail, row). Views observe `contacts` and call
/// the mutation methods — they never touch the store directly.
final class ContactsViewModel: ObservableObject {

    /// Full in-memory list. Views read this; only the view model writes it.
    @Published private(set) var contacts: [ContactData] = []

    private let store: ContactStore

    init(store: ContactStore) {
        self.store = store
        // TODO: self.contacts = (try? store.load()) ?? []
        // TODO: optionally seed sample contacts on first launch
    }

    // MARK: - CRUD

    func add(_ contact: ContactData) {
        // TODO: append + persist()
    }

    func update(_ contact: ContactData) {
        // TODO: replace by identity + persist()
    }

    func delete(_ contact: ContactData) {
        // TODO: remove by identity + persist()
    }

    // MARK: - Derived state

    /// Contacts grouped into alphabetical sections by surname initial,
    /// sorted A→Z, with each section internally sorted by surname.
    var groupedBySurname: [(letter: String, contacts: [ContactData])] {
        // TODO: Dictionary(grouping: contacts, by: \.surnameInitial)
        //       → sort keys → sort each bucket by surname
        []
    }

    // MARK: - Validation

    /// Returns a Polish error message if the contact is invalid,
    /// or `nil` when it's ready to be saved.
    static func validate(_ contact: ContactData) -> String? {
        // TODO: check name / surname / phone / email non-empty, formats
        nil
    }

    // MARK: - Persistence

    private func persist() {
        // TODO: try? store.save(contacts)
    }
}
