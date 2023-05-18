//
//  StopWatchManager.swift
//  stopWatch
//
//  Created by delmas vassily on 04/03/2022.
//

import SwiftUI

class StopWatchManager : ObservableObject {

    @Published var miliseconds = 0
    @Published var seconds = 0
    @Published var minutes = 0

    @Published var isStarted = false
    @Published var isPaused = false
    
    var timer = Timer()

    func start() {
        isStarted = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in

        if(self.miliseconds == 99) {
            if (self.seconds == 59) {
                self.seconds = 0
                self.minutes += 1
            } else {
                self.seconds += 1
            }
            self.miliseconds = 0
        }

        self.miliseconds += 1
        }
    }

    func pause() {

            isPaused = true
            isStarted = false
            timer.invalidate()

    }

    func restart() {

            isStarted = false
            timer.invalidate()
            self.minutes = 0
            self.seconds = 0
            self.miliseconds = 0

    }

}
