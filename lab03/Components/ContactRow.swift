//
//  ContactRow.swift
//  lab03
//
//  Created by Danylo Lukianiuk on 27/03/2026.
//

import SwiftUI

struct ContactRow: View {
    let contact: ContactData
 
    var body: some View {
        HStack(spacing: 12) {
            Text(contact.surnameInitial)
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(Color.blue)
                .clipShape(Circle())
 
            VStack(alignment: .leading, spacing: 2) {
                Text(contact.fullName)
                    .font(.body)
                Text(contact.phoneNumber)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}
