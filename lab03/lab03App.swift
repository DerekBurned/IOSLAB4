//
//  lab03App.swift
//  lab03
//
//  Created by Danylo Lukianiuk on 20/03/2026.
//

import SwiftUI

@main
struct lab03App: App {
    @StateObject private var viewModel = ContactsViewModel(store:FileContactStore())
    var body: some Scene {
        WindowGroup {
            ContactList().environmentObject(viewModel)
            
        }
    }
}
#Preview{
    NavigationStack{
        ContactFormView().environmentObject(ContactsViewModel(store: FileContactStore()))
    }
}
