//
//  SectionLabel.swift
//  lab03
//
//  Created by Danylo Lukianiuk on 27/03/2026.
//

import SwiftUI



struct SectionLabel: View {
    let title: String
    let systemImage: String

    var body: some View {
        Label(title, systemImage: systemImage)
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundColor(.primary)
    }
}
