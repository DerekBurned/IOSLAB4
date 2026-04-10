//
//  ContactList.swift
//  lab03
//
//  Created by Danylo Lukianiuk on 27/03/2026.
//

import SwiftUI

struct ContactList: View {
    @EnvironmentObject var viewModel: ContactsViewModel

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.groupedBySurname, id: \.letter) { section in
                    Section(header: Text(section.letter)) {
                        ForEach(section.contacts) { contact in
                            NavigationLink(destination: ContactSummaryView(contactData: contact)) {
                                ContactRow(contact: contact)
                            }
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Kontakty")
        }
    }
}
