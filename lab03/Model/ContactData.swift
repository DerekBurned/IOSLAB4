//
//  ContactData.swift
//  lab03
//
//  Created by Danylo Lukianiuk on 27/03/2026.
//
import SwiftUI

struct ContactData {
    var name: String = ""
    var surname: String = ""
    var phoneNumber: String = ""
    var address: String = ""
    var city: String = ""
    var postalCode: String = ""
    var birthDate: Date = Date()
    var gender: Gender = .male
    var notificationsEnabled: Bool = false
    var fullName: String { "\(name) \(surname)" }
    var surnameInitial: String { String(surname.prefix(1)).uppercased() }

    enum Gender: String, CaseIterable {
        case male = "Mężczyzna"
        case female = "Kobieta"
        case other = "Inne"
    }

    /// Convenience init to create ContactData from a Contact list item

    init(name: String = "", surname:String = "", phoneNumber: String = "", address: String = "",
         city: String = "", postalCode: String = "", birthDate: Date = Date(),
         gender: Gender = .male, notificationsEnabled: Bool = false) {
        self.name = name
        self.surname = surname
        self.phoneNumber = phoneNumber
        self.address = address
        self.city = city
        self.postalCode = postalCode
        self.birthDate = birthDate
        self.gender = gender
        self.notificationsEnabled = notificationsEnabled
    }
}
