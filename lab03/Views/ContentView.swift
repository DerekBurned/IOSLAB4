//
//  ContentView.swift
//  lab03
//
//  Created by Danylo Lukianiuk on 20/03/2026.
//

//
//  ContentView.swift
//  lab03
//
//  Created by Danylo Lukianiuk on 20/03/2026.
//

import SwiftUI

struct ContactFormView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: ContactViewModel // Upewnij się, że używasz ContactsViewModel
    
    var contactToEdit: ContactData?
    @State private var errorMessage: String?
    @State private var showValidationError = false
    
    // Wymagane pola
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var phoneNumber = ""
    
    // Opcjonalne pola
    @State private var email = ""
    @State private var address = ""
    @State private var city = ""
    @State private var postalCode = ""
    @State private var birthDate = Date()
    @State private var gender: ContactData.Gender = .male
    @State private var notificationsEnabled = false
    
    enum Field { case firstName, lastName, phone, email, address, city, postalCode }
    @FocusState private var focusedField: Field?
    
    var body: some View {
        Form {
            Section(header: Text("Wymagane")) {
                TextField("Imię", text: $firstName)
                    .focused($focusedField, equals: .firstName)
                    .submitLabel(.next)
                    .onSubmit { focusedField = .lastName }
                
                TextField("Nazwisko", text: $lastName)
                    .focused($focusedField, equals: .lastName)
                    .submitLabel(.next)
                    .onSubmit { focusedField = .phone }
                
                TextField("Numer telefonu", text: $phoneNumber)
                    .keyboardType(.phonePad)
                    .focused($focusedField, equals: .phone)
                    .submitLabel(.next)
                    .onSubmit { focusedField = .email }
            }
            
            Section(header: Text("Kontakt i Adres (Opcjonalne)")) {
                TextField("E-mail", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .email)
                    .submitLabel(.next)
                    .onSubmit { focusedField = .address }
                
                TextField("Ulica i numer", text: $address)
                    .focused($focusedField, equals: .address)
                    .submitLabel(.next)
                    .onSubmit { focusedField = .city }
                
                TextField("Miasto", text: $city)
                    .focused($focusedField, equals: .city)
                    .submitLabel(.next)
                    .onSubmit { focusedField = .postalCode }
                
                TextField("Kod pocztowy", text: $postalCode)
                    .keyboardType(.numbersAndPunctuation)
                    .focused($focusedField, equals: .postalCode)
                    .submitLabel(.done)
                    .onSubmit { focusedField = nil }
            }
            
            Section(header: Text("Pozostałe (Opcjonalne)")) {
                DatePicker("Data urodzenia", selection: $birthDate, displayedComponents: .date)
                    // Optional: limit dates to the past
                    .datePickerStyle(.compact)
                
                Picker("Płeć", selection: $gender) {
                    ForEach(ContactData.Gender.allCases, id: \.self) { genderOption in
                        Text(genderOption.rawValue).tag(genderOption)
                    }
                }
                
                Toggle("Włącz powiadomienia", isOn: $notificationsEnabled)
                    .tint(.blue)
            }
            .dismissKeyboardOnTap() // Helper keeps keyboard from blocking pickers/toggles
            
            Button(action: saveContact) {
                Text(contactToEdit == nil ? "Zapisz" : "Zapisz zmiany")
                    .frame(maxWidth: .infinity)
                    .bold()
            }
        }
        .navigationTitle(contactToEdit == nil ? "Nowy kontakt" : "Edytuj kontakt")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if let contact = contactToEdit {
                firstName = contact.name
                lastName = contact.surname
                phoneNumber = contact.phoneNumber
                email = contact.email
                address = contact.address
                city = contact.city
                postalCode = contact.postalCode
                birthDate = contact.birthDate
                gender = contact.gender
                notificationsEnabled = contact.notificationsEnabled
            } else {
                focusedField = .firstName
            }
        }
        .alert("Błąd walidacji", isPresented: $showValidationError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage ?? "Wystąpił nieznany błąd.")
        }
    }
    
    private func saveContact() {
        var contact = contactToEdit ?? ContactData()
        
        // Zapisujemy wszystkie pola
        contact.name = firstName
        contact.surname = lastName
        contact.phoneNumber = phoneNumber
        contact.email = email
        contact.address = address
        contact.city = city
        contact.postalCode = postalCode
        contact.birthDate = birthDate
        contact.gender = gender
        contact.notificationsEnabled = notificationsEnabled
        
        // Capture the error and trigger the alert!
        if let validationError = ContactViewModel.validate(contact) {
            self.errorMessage = validationError
            self.showValidationError = true
            return
        }
        
        // If we get past validation, save the contact
        if contactToEdit != nil {
            viewModel.update(contact)
        } else {
            viewModel.add(contact)
        }
        
        // Go back to the list
        dismiss()
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
    .environmentObject(ContactViewModel(store: FileContactStore()))
}
