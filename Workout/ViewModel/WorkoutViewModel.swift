//
//  WorkoutViewModel.swift
//  Workout
//
//  Created by blind heitz nathan on 03/03/2022.
//

import SwiftUI

class WorkoutViewModel: ObservableObject {
    
    @Published var workouts: [Workout] = []
    
    init() {
        getWorkouts()
    }
    
    func getWorkouts() {
        workouts.append(contentsOf: Workout.testData)
    }
    
    func addItem(category: Category, date: Date, time: Time, perform: Perform, points: [MapLocation]) {
        let newWorkout = Workout(categogy: category, date: date, time: time, perform: perform, points: points)
        workouts.insert(newWorkout, at: 0)
    }
    
    func deleteItem(indexSet: IndexSet) {
        workouts.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        workouts.move(fromOffsets: from, toOffset: to)
    }
    
}
