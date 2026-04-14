//
//  CoreDataContactStore.swift
//  lab03
//
//  Created by Programista on 14/04/2026.
//

import Foundation
import CoreData

/// CoreData implementation of ContactStore.
final class CoreDataContactStore: ContactStore {
    
    // Set up the Core Data container
    private let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "ContactsModel") // MUST match your .xcdatamodeld filename
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }
    
    // MARK: - ContactStore Protocol Requirements
    
    func load() throws -> [ContactData] {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<CDContact> = CDContact.fetchRequest()
        
        do {
            let coreDataContacts = try context.fetch(fetchRequest)
            
            // Map the Core Data objects back into our normal Swift structs
            return coreDataContacts.map { cdContact in
                ContactData(
                    id: cdContact.id ?? UUID(),
                    name: cdContact.name ?? "",
                    surname: cdContact.surname ?? "",
                    phoneNumber: cdContact.phoneNumber ?? "",
                    email: cdContact.email ?? "",
                    address: cdContact.address ?? "",
                    city: cdContact.city ?? "",
                    postalCode: cdContact.postalCode ?? "",
                    birthDate: cdContact.birthDate ?? Date(),
                    // Convert the stored string back to the Gender enum, default to .male if it fails
                    gender: ContactData.Gender(rawValue: cdContact.gender ?? "") ?? .male,
                    notificationsEnabled: cdContact.notificationsEnabled
                )
            }
        } catch {
            print("Failed to fetch contacts: \(error)")
            throw error
        }
    }
    
    func save(_ contacts: [ContactData]) throws {
        let context = container.viewContext
        
    
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CDContact.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            
            // 2. Insert the new ones
            for contact in contacts {
                let cdContact = CDContact(context: context)
                cdContact.id = contact.id
                cdContact.name = contact.name
                cdContact.surname = contact.surname
                cdContact.phoneNumber = contact.phoneNumber
                cdContact.email = contact.email
                cdContact.address = contact.address
                cdContact.city = contact.city
                cdContact.postalCode = contact.postalCode
                cdContact.birthDate = contact.birthDate
                cdContact.gender = contact.gender.rawValue // Save the enum as a String
                cdContact.notificationsEnabled = contact.notificationsEnabled
            }
            
            // 3. Commit the changes
            try context.save()
            
        } catch {
            print("Failed to save to Core Data: \(error)")
            throw error
        }
    }
}
