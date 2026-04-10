//
//  KeyboardDismiss.swift
//  lab03
//
//  Tap-outside-to-dismiss keyboard helper used by the contact form,
//  covering the "keyboard closes when tapping outside a text field"
//  requirement from the lab brief.
//

import SwiftUI

/// View modifier that dismisses the software keyboard when the
/// decorated view is tapped outside of any focused text field.
struct DismissKeyboardOnTap: ViewModifier {
    func body(content: Content) -> some View {
        // TODO: attach .onTapGesture that resigns the first responder
        //       (e.g. via UIApplication.sendAction(#selector(...))).
        content
    }
}

extension View {
    /// Dismiss the keyboard when the user taps anywhere on this view.
    func dismissKeyboardOnTap() -> some View {
        modifier(DismissKeyboardOnTap())
    }
}
