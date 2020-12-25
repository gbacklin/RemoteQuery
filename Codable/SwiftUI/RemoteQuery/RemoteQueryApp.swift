//
//  RemoteQueryApp.swift
//  RemoteQuery
//
//  Created by Gene Backlin on 12/24/20.
//

import SwiftUI

@main
struct RemoteQueryApp: App {
    @Environment(\.scenePhase) private var scenePhase
    var personQuery = PersonQueryManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(personQuery)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .active {
            }
        }
    }
}
