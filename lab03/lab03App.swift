//
//  lab03App.swift
//  lab03
//
//  Created by Danylo Lukianiuk on 20/03/2026.
//

import SwiftUI

@main
struct ContactsApp: App {
    // We will change this to CoreDataContactStore in Part 2!
    @StateObject private var viewModel = ContactsViewModel(store: CoreDataContactStore())
    
    // MARK: - Background Timer Properties
    @Environment(\.scenePhase) var scenePhase
    
    // AppStorage automatically saves these to UserDefaults
    @AppStorage("totalBackgroundTime") private var totalBackgroundTime: TimeInterval = 0
    @AppStorage("lastBackgroundTimestamp") private var lastBackgroundTimestamp: Double = 0
    
    var body: some Scene {
        WindowGroup {
            ContactsListView()
                .environmentObject(viewModel)
        }
        .onChange(of: scenePhase) { newPhase in
            switch newPhase {
            case .background:
                // Save the exact moment the app went to the background
                lastBackgroundTimestamp = Date().timeIntervalSince1970
                print("App went to background.")
                
            case .active:
                // When the app comes back, calculate the time spent away
                if lastBackgroundTimestamp > 0 {
                    let timeAway = Date().timeIntervalSince1970 - lastBackgroundTimestamp
                    totalBackgroundTime += timeAway
                    lastBackgroundTimestamp = 0 // Reset for the next time
                    
                    // Format to 2 decimal places for easy reading
                    let formattedTime = String(format: "%.2f", totalBackgroundTime)
                    print("App is back! Total time spent closed/suspended: \(formattedTime) seconds")
                }
                
            case .inactive:
                // App is transitioning, we don't need to do anything here
                break
            @unknown default:
                break
            }
        }
    }
}
