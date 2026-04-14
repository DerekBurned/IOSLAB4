//
//  ContactSummaryView.swift
//  lab03
//
//  Created by Danylo Lukianiuk on 27/03/2026.
//
import SwiftUI

struct ContactSummaryView: View {
    @EnvironmentObject var viewModel: ContactViewModel
    let contactData: ContactData
    @Environment(\.dismiss) private var dismiss

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.locale = Locale(identifier: "pl_PL")
        return formatter.string(from: contactData.birthDate)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                VStack(spacing: 4) {
                    Image(systemName: "checkmark.seal.fill")
                        .font(.system(size: 48))
                        .foregroundColor(.green)
                    Text("Dane kontaktowe")
                        .font(.title.bold())
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)

                GroupBox(label: SectionLabel(title: "Dane osobowe", systemImage: "person.fill")) {
                    VStack(spacing: 0) {
                        SummaryRow(title: "Imię i nazwisko", value: contactData.fullName)
                        Divider()
                        SummaryRow(title: "Numer telefonu", value: contactData.phoneNumber)
                    }
                    .padding(.top, 8)
                }

                GroupBox(label: SectionLabel(title: "Adres", systemImage: "house.fill")) {
                    VStack(spacing: 0) {
                        SummaryRow(title: "Ulica", value: contactData.address)
                        Divider()
                        SummaryRow(title: "Miasto", value: contactData.city)
                        Divider()
                        SummaryRow(title: "Kod pocztowy", value: contactData.postalCode)
                    }
                    .padding(.top, 8)
                }

                GroupBox(label: SectionLabel(title: "Pozostałe", systemImage: "info.circle.fill")) {
                    VStack(spacing: 0) {
                        SummaryRow(title: "Data urodzenia", value: formattedDate)
                        Divider()
                        SummaryRow(title: "Płeć", value: contactData.gender.rawValue)
                        Divider()
                        SummaryRow(title: "Powiadomienia", value: contactData.notificationsEnabled ? "Tak ✓" : "Nie ✗")
                    }
                    .padding(.top, 8)
                }

                Button(action: { dismiss() }) {
                    Text("Zamknij")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.top, 8)
            }
            .padding()
        }
        .navigationTitle("Podsumowanie")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Zadzwoń") {
                            makePhoneCall()
                        }
                    }
                }
    }
    private func makePhoneCall() {
            // Usuwamy spacje z numeru, np. "+48 123 456 789" -> "+48123456789"
            let cleanPhoneNumber = contactData.phoneNumber.replacingOccurrences(of: " ", with: "")
            
            // Tworzymy URL do aplikacji telefonu
            if let phoneURL = URL(string: "tel://\(cleanPhoneNumber)"),
               UIApplication.shared.canOpenURL(phoneURL) {
                UIApplication.shared.open(phoneURL)
            }
        }
    
}

#Preview("Summary") {
    NavigationStack {
        ContactSummaryView(contactData: ContactData(
            name: "Jan",
            surname: "Kowalski",
            phoneNumber: "+48 123 456 789",
            address: "ul. Przykładowa 1",
            city: "Warszawa",
            postalCode: "00-001",
            birthDate: Date(),
            gender: .male,
            notificationsEnabled: true
        ))
    }
}
