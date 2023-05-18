//
//  WorkoutListView.swift
//  Workout
//
//  Created by blind heitz nathan on 03/03/2022.
//

import SwiftUI

struct WorkoutListView: View {
    
    @EnvironmentObject var data: WorkoutViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(data.workouts) { workout in
                    NavigationLink(destination: WorkoutDetailsView(workout: workout)) {
                        RowWorkoutView(workout: workout)
                    }
                }
                .onDelete(perform: data.deleteItem)
                .onMove(perform: data.moveItem)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Workouts").font(.system(size: 16, weight: .medium))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
        
        }
    }
}

struct WorkoutListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListView()
            .environmentObject(WorkoutViewModel())
    }
}
