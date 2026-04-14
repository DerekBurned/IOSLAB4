//
//  ContactList.swift
//  lab03
//
//  Created by Danylo Lukianiuk on 27/03/2026.
//

import SwiftUI

struct ContactsListView: View {
    // FIX: Match the standardized ViewModel name
    @EnvironmentObject var viewModel: ContactsViewModel
    
    @State private var contactToDelete: ContactData? // FIX: Change Contact to ContactData
    @State private var showDeleteAlert = false
    @AppStorage("totalBackgroundTime") private var totalBackgroundTime: TimeInterval = 0
    var body: some View {
        NavigationStack {
            if totalBackgroundTime > 0 {
                                Text("Czas poza aplikacją: \(String(format: "%.1f", totalBackgroundTime)) s")
                                    .font(.caption)
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 12)
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(8)
                                    .foregroundColor(.blue)
                            }
            List {
                // FIX: Use groupedBySurname instead of groupedContacts
                ForEach(viewModel.groupedBySurname, id: \.letter) { group in
                    Section(header: Text(group.letter)) {
                        // FIX: Use group.contacts instead of group.value
                        ForEach(group.contacts) { contact in
                            // FIX: Use ContactSummaryView instead of ContactDetailView
                            NavigationLink(destination: ContactSummaryView(contactData: contact)) {
                                VStack(alignment: .leading) {
                                    // FIX: Use fullName instead of firstName/lastName
                                    Text(contact.fullName)
                                        .font(.headline)
                                    Text(contact.phoneNumber)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button(role: .destructive) {
                                    contactToDelete = contact
                                    showDeleteAlert = true
                                } label: {
                                    Label("Usuń", systemImage: "trash")
                                }
                                
                                NavigationLink {
                                    ContactFormView(contactToEdit: contact)
                                } label: {
                                    Label("Edytuj", systemImage: "pencil")
                                }
                                .tint(.green)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Kontakty")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ContactFormView(contactToEdit: nil)) {
                        Image(systemName: "plus")
                    }
                }
            }
            .alert("Potwierdzenie", isPresented: $showDeleteAlert, presenting: contactToDelete) { contact in
                Button("Anuluj", role: .cancel) { }
                Button("Usuń", role: .destructive) {
                    viewModel.delete(contact)
                }
            } message: { _ in
                Text("Czy na pewno chcesz usunąć ten kontakt?")
            }
        }
    }
}
