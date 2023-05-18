//
//  RowWorkoutView.swift
//  Workout
//
//  Created by blind heitz nathan on 03/03/2022.
//

import SwiftUI
import MapKit

struct RowWorkoutView: View {
    
    let workout: Workout
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: workout.categogy.icon)
                Text(workout.getFormattedDate())
            }
            MapView(workout: workout)
                .frame(width: 250, height: 250)
        }
    }
}

struct RowWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(Workout.testData) { workout in
            RowWorkoutView(workout: workout)
                .previewLayout(.sizeThatFits)
        }
    }
}
