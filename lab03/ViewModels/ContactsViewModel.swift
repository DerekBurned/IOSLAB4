//
//  ContactsViewModel.swift
//  lab03
//
//  Owns the contact list, exposes CRUD + grouping/sorting,
//  and persists changes through an injected ContactStore.
//

import Foundation
import Combine

/// Single source of truth for the contact list screen and all its
/// children (form, detail, row). Views observe `contacts` and call
/// the mutation methods — they never touch the store directly.
final class ContactViewModel: ObservableObject {

    /// Full in-memory list. Views read this; only the view model writes it.
    @Published private(set) var contacts: [ContactData] = []
    
    private let store: ContactStore

    init(store: ContactStore) {
        self.store = store
        self.contacts = (try? store.load()) ?? []
        // TODO: optionally seed sample contacts on first launch
    }

    // MARK: - CRUD

    func add(_ contact: ContactData) {
        // TODO: append + persist()
        contacts.append(contact)
            persist()
    }

    func update(_ contact: ContactData) {
        // TODO: replace by identity + persist()
        guard let index = contacts.firstIndex(where: { $0.id == contact.id }) else { return }
        contacts[index]  = contact
        persist()
    }

    func delete(_ contact: ContactData) {
            contacts.removeAll { $0.id == contact.id }
            persist()
        }

    // MARK: - Derived state

    /// Contacts grouped into alphabetical sections by surname initial,
    /// sorted A→Z, with each section internally sorted by surname.
    var groupedBySurname: [(letter: String, contacts: [ContactData])] {
            let groups = Dictionary(grouping: contacts) { $0.surnameInitial }
            return groups
                .map { (letter: $0.key, contacts: $0.value.sorted { $0.surname.localizedCaseInsensitiveCompare($1.surname) == .orderedAscending }) }
                .sorted { $0.letter < $1.letter }
        }
    // MARK: - Validation

    /// Returns a Polish error message if the contact is invalid,
    /// or `nil` when it's ready to be saved.
    static func validate(_ contact: ContactData) -> String? {
            if contact.name.trimmingCharacters(in: .whitespaces).isEmpty {
                return "Pole \"Imię\" jest wymagane."
            }
            if contact.surname.trimmingCharacters(in: .whitespaces).isEmpty {
                return "Pole \"Nazwisko\" jest wymagane."
            }
            if contact.phoneNumber.trimmingCharacters(in: .whitespaces).isEmpty {
                return "Pole \"Numer telefonu\" jest wymagane."
            }
            
            // E-mail is optional, but if it has text, it must be valid
            if !contact.email.trimmingCharacters(in: .whitespaces).isEmpty {
                if !isValidEmail(contact.email) {
                    return "Nieprawidłowy format adresu e-mail."
                }
            }
            return nil
        }

        private static func isValidEmail(_ email: String) -> Bool {
            let pattern = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
            return email.range(of: pattern, options: .regularExpression) != nil
        }


    // MARK: - Persistence

    private func persist() {
        // TODO: try? store.save(contacts)
        try? store.save(contacts)
    }
}
