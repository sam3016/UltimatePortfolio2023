//
//  UltimatePortfolio2023App.swift
//  UltimatePortfolio2023
//
//  Created by Sam Hui on 2023/03/20.
//

import SwiftUI

@main
struct UltimatePortfolio2023App: App {
    @StateObject var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            NavigationSplitView {
                SidebarView()
            } content: {
                ContentView()
            } detail: {
                DetailView()
            }
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
        }
    }
}