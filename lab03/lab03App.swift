//
//  lab03App.swift
//  lab03
//
//  Created by Danylo Lukianiuk on 20/03/2026.
//

import SwiftUI

@main
struct ContactsApp: App {
    @StateObject private var viewModel = ContactViewModel(store: FileContactStore())
    
    var body: some Scene {
        WindowGroup {
            ContactsListView()
               .environmentObject(viewModel)
        }
    }
}
