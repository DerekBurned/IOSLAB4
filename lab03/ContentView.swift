//
//  ContentView.swift
//  lab03
//
//  Created by Danylo Lukianiuk on 20/03/2026.
//

import SwiftUI

struct ContactFormView: View {
    @State private var contactData: ContactData
    @State private var showValidationAlert = false
    @State private var validationMessage = ""
    @State private var navigateToSummary = false

    init(contactData: ContactData = ContactData()) {
        _contactData = State(initialValue: contactData)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                GroupBox(label: SectionLabel(title: "Dane osobowe", systemImage: "person.fill")) {
                    VStack(spacing: 12) {
                        FormField(title: "Imię", placeholder: "Jan Kowalski", text: $contactData.name)
                        FormField(title: "Imię", placeholder: "Jan Kowalski", text: $contactData.surname)
                            .keyboardType(.default)
                        FormField(title: "Numer telefonu", placeholder: "+48 123 456 789", text: $contactData.phoneNumber)
                            .keyboardType(.phonePad)
                    }
                    .padding(.top, 8)
                }

                GroupBox(label: SectionLabel(title: "Adres", systemImage: "house.fill")) {
                    VStack(spacing: 12) {
                        FormField(title: "Ulica", placeholder: "ul. Przykładowa 1", text: $contactData.address)
                        FormField(title: "Miasto", placeholder: "Warszawa", text: $contactData.city)
                        FormField(title: "Kod pocztowy", placeholder: "00-000", text: $contactData.postalCode)
                            .keyboardType(.numbersAndPunctuation)
                    }
                    .padding(.top, 8)
                }

                GroupBox(label: SectionLabel(title: "Data urodzenia", systemImage: "calendar")) {
                    DatePicker(
                        "Wybierz datę",
                        selection: $contactData.birthDate,
                        in: ...Date(),
                        displayedComponents: .date
                    )
                    .datePickerStyle(.compact)
                    .environment(\.locale, Locale(identifier: "pl_PL"))
                    .padding(.top, 8)
                }

                GroupBox(label: SectionLabel(title: "Płeć", systemImage: "person.2.fill")) {
                    Picker("Płeć", selection: $contactData.gender) {
                        ForEach(ContactData.Gender.allCases, id: \.self) { gender in
                            Text(gender.rawValue).tag(gender)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.top, 8)
                }

                GroupBox(label: SectionLabel(title: "Preferencje", systemImage: "bell.fill")) {
                    Toggle("Otrzymuj powiadomienia", isOn: $contactData.notificationsEnabled)
                        .tint(.blue)
                        .padding(.top, 8)
                }

                Button(action: handleNextButton) {
                    Text("Przejdź dalej")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.top, 8)
            }
            .padding()
        }
        .navigationDestination(isPresented: $navigateToSummary) {
            ContactSummaryView(contactData: contactData)
        }
        .navigationTitle("Formularz kontaktowy")
        .navigationBarTitleDisplayMode(.large)
        .scrollDismissesKeyboard(.immediately)
        .alert("Błąd walidacji", isPresented: $showValidationAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(validationMessage)
        }
    }

    private func handleNextButton() {
        if let error = validate() {
            validationMessage = error
            showValidationAlert = true
        } else {
            navigateToSummary = true
        }
    }

    private func validate() -> String? {
        if contactData.name.trimmingCharacters(in: .whitespaces).isEmpty {
            return "Pole \"Imię\" jest wymagane."
        }
        if contactData.surname.trimmingCharacters(in: .whitespaces).isEmpty {
            return "Pole \"Imię\" jest wymagane."
        }
        if contactData.phoneNumber.trimmingCharacters(in: .whitespaces).isEmpty {
            return "Pole \"Numer telefonu\" jest wymagane."
        }
        if contactData.address.trimmingCharacters(in: .whitespaces).isEmpty {
            return "Pole \"Adres\" jest wymagane."
        }
        if contactData.city.trimmingCharacters(in: .whitespaces).isEmpty {
            return "Pole \"Miasto\" jest wymagane."
        }
        if contactData.postalCode.trimmingCharacters(in: .whitespaces).isEmpty {
            return "Pole \"Kod pocztowy\" jest wymagane."
        }
        return nil
    }
}

// MARK: - Components

struct FormField: View {
    let title: String
    let placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
            TextField(placeholder, text: $text)
                .padding(10)
                .background(Color(.systemBackground))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                )
                .submitLabel(.done)
        }
    }
}

#Preview("Form") {
    NavigationStack {
        ContactFormView()
    }
}
