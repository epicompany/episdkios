//
//  EPISDKExampleApp.swift
//  EPISDKExample
//
//  Created by Krzysztof Rodak on 29/05/2023.
//

import SwiftUI

@main
struct EPISDKExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: .init(container: DIContainer()))
        }
    }
}
