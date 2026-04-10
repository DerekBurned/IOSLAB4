//
//  ContactData.swift
//  lab03
//
//  Created by Danylo Lukianiuk on 27/03/2026.
//
import SwiftUI

struct ContactData: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String = ""
    var surname: String = ""
    var phoneNumber: String = ""
    var email: String = ""
    var address: String = ""
    var city: String = ""
    var postalCode: String = ""
    var birthDate: Date = Date()
    var gender: Gender = .male
    var notificationsEnabled: Bool = false

    var fullName: String { "\(name) \(surname)" }
    var surnameInitial: String { String(surname.prefix(1)).uppercased() }

    enum Gender: String, CaseIterable, Codable {
        case male = "Mężczyzna"
        case female = "Kobieta"
        case other = "Inne"
    }

    init(id: UUID = UUID(),
         name: String = "",
         surname: String = "",
         phoneNumber: String = "",
         email: String = "",
         address: String = "",
         city: String = "",
         postalCode: String = "",
         birthDate: Date = Date(),
         gender: Gender = .male,
         notificationsEnabled: Bool = false) {
        self.id = id
        self.name = name
        self.surname = surname
        self.phoneNumber = phoneNumber
        self.email = email
        self.address = address
        self.city = city
        self.postalCode = postalCode
        self.birthDate = birthDate
        self.gender = gender
        self.notificationsEnabled = notificationsEnabled
    }
}
