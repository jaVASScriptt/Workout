//
//  ContentView.swift
//  Workout
//
//  Created by blind heitz nathan & delmas vassily on 03/03/2022.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            TimerView()
                .tabItem {
                    Image(systemName: "timer")
                    Text("Timer")
                }
            WorkoutListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Workouts")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(WorkoutViewModel())
    }
}
