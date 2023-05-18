//
//  WorkoutApp.swift
//  Workout
//
//  Created by blind heitz nathan on 03/03/2022.
//

import SwiftUI

@main
struct WorkoutApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(WorkoutViewModel())
        }
    }
}
