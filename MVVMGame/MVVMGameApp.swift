//
//  MVVMGameApp.swift
//  MVVMGame
//
//  Created by Русинов Евгений on 05.08.2023.
//

import SwiftUI

let screen = UIScreen.main.bounds

@main
struct MVVMGameApp: App {
    var body: some Scene {
        WindowGroup {
            StartView()
        }
    }
}
