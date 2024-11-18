//
//  PulsePointApp.swift
//  PulsePoint
//
//  Created by Yusuf Ansar  on 15/11/24.
//

import SwiftUI

@main
struct PulsePointApp: App {

    @State var bookmarksViewModel = BookmarksViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(bookmarksViewModel)
        }
    }
}
