//
//  ContactList.swift
//  lab03
//
//  Created by Danylo Lukianiuk on 27/03/2026.
//

import SwiftUI



struct ContactList: View {
    
    @State  static var contacts: [ContactData] = [
        ContactData(
            name: "Anna",
            surname: "Kowalska",
            phoneNumber: "+48 123 456 789",
            address: "ul. Marszałkowska 12",
            city: "Warszawa",
            postalCode: "00-001",
            birthDate: Date(timeIntervalSince1970: 757382400), // 1994-01-01
            gender: .female,
            notificationsEnabled: true
        ),
        ContactData(
            name: "Piotr",
            surname: "Nowak",
            phoneNumber: "+48 987 654 321",
            address: "ul. Długa 5",
            city: "Kraków",
            postalCode: "30-001",
            birthDate: Date(timeIntervalSince1970: 631152000), // 1990-01-01
            gender: .male,
            notificationsEnabled: false
        ),
        ContactData(
            name: "Maja",
            surname: "Wiśniewska",
            phoneNumber: "+48 555 111 222",
            address: "ul. Kwiatowa 3",
            city: "Wrocław",
            postalCode: "50-001",
            birthDate: Date(timeIntervalSince1970: 883612800), // 1997-12-31
            gender: .female,
            notificationsEnabled: true
        ),
        ContactData(
            name: "Tomasz",
            surname: "Zając",
            phoneNumber: "+48 600 200 300",
            address: "ul. Słoneczna 8",
            city: "Gdańsk",
            postalCode: "80-001",
            birthDate: Date(timeIntervalSince1970: 504921600), // 1986-01-01
            gender: .male,
            notificationsEnabled: false
        ),
        ContactData(
            name: "Alex",
            surname: "Rutkowski",
            phoneNumber: "+48 700 800 900",
            address: "ul. Lipowa 21",
            city: "Poznań",
            postalCode: "60-001",
            birthDate: Date(timeIntervalSince1970: 978307200), // 2001-01-01
            gender: .other,
            notificationsEnabled: true
        )
    ]

    var groupedContacts: [String: [ContactData]] {
        Dictionary(grouping: ContactData) { $0.surnameInitial }
    }

    var sortedKeys: [String] {
        groupedContacts.keys.sorted()
    }

    var body: some View {
        NavigationStack {
 
            List {
                ForEach(sortedKeys, id: \.self) { letter in
                    Section(header: Text(letter)) {
                        ForEach(groupedContacts[letter]!.sorted { $0.surname < $1.surname }) { contact in
                            NavigationLink(destination: ContactSummaryView(contactData: ContactData(from: contact))) {
                                ContactRow(contact: contact)
                            }
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Contacts")
            .overlay(
                VStack {
                    ForEach(sortedKeys, id: \.self) { letter in
                        Text(letter)
                            .font(.caption.bold())
                            .foregroundStyle(.blue)
                    }
                },
                alignment: .trailing
            )
        }
    }
}
