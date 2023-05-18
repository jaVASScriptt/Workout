//
//  TimerView.swift
//  Workout
//
//  Created by blind heitz nathan on 03/03/2022.
//

import SwiftUI
import MapKit

struct TimerView: View {
    
    @State var category: Category = .bike
    @StateObject var stopWatchManager = StopWatchManager()
    @StateObject var locData = LocationViewModel()
    
    var body: some View {
        VStack {
            Text(category.rawValue.capitalized)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(Color.black)
                            
            Spacer()
            
            HStack {
                textTime(label:
                    stopWatchManager.minutes < 10 ?
                         "0\(stopWatchManager.minutes)":"\(stopWatchManager.minutes)")
                
                    textTime(label: ":")
                
                textTime(label:
                    stopWatchManager.seconds < 10 ?
                         "0\(stopWatchManager.seconds)":"\(stopWatchManager.seconds)")
                
                    textTime(label: ":")
                
                textTime(label:
                    stopWatchManager.miliseconds < 10 ?
                         "0\(stopWatchManager.miliseconds)":"\(stopWatchManager.miliseconds)")
            }
            .padding()
            
            Text("\((String(format: "%.2f", locData.distance))) m")
                .font(.system(size: 45, weight: .medium))
                .foregroundColor(Color.black)
            
            Spacer()
            
            Picker("Category", selection: $category) {
                ForEach(Category.allCases, id: \.self) {
                    Image(systemName: $0.icon)
                }
            }
            .pickerStyle(.segmented)
            .disabled(stopWatchManager.isStarted)
            .disabled(stopWatchManager.isPaused)
            .padding()
            
            ButtonGo(stopWatchManager: stopWatchManager, locationViewModel: locData, category: category)
        }
    }
}

struct textTime: View {
    
    let label: String
    
    var body: some View {
        Text(label)
            .font(.custom("Avenir", size: 50) .bold())
            .foregroundColor(Color.black)

    }
    
}

struct ButtonGo: View {
    
    @ObservedObject var stopWatchManager: StopWatchManager
    @ObservedObject var locationViewModel: LocationViewModel
    @EnvironmentObject var data: WorkoutViewModel
    private let locationManager = CLLocationManager()
    var category : Category
    
    
    var body: some View {
        
        HStack{
            if(stopWatchManager.isPaused) {
                Button {
                    data.addItem(category: category, date: Date(), time: Time(min: stopWatchManager.minutes, sec: stopWatchManager.seconds, mili: stopWatchManager.miliseconds), perform: Perform(distance: locationViewModel.distance, speed: locationViewModel.distance / Double(stopWatchManager.seconds)), points: [locationViewModel.startPoint, MapLocation(coordinate: locationManager.location!.coordinate)])
                    stopWatchManager.isPaused = false
                    stopWatchManager.restart()
                    locationViewModel.stopGetDistance()
                } label: {
                    HStack {
                        Image(systemName: "stop.fill")
                        Text("Stop")
                    }
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.red)
                    .cornerRadius(30)
                    .padding(.leading, 30)
                }
            }
        
            Button {
                if (!stopWatchManager.isStarted && !stopWatchManager.isPaused) {
                    locationViewModel.startPoint = MapLocation(coordinate: locationManager.location!.coordinate)
                    locationViewModel.getDistance(locationManager)
                }
                stopWatchManager.isPaused = false
                if stopWatchManager.isStarted {
                    self.stopWatchManager.pause()
                    locationViewModel.pauseGetDistance()
                } else {
                    self.stopWatchManager.start()
                    locationViewModel.getDistance(locationManager)
                }
            } label: {
                HStack {
                    Image(systemName: stopWatchManager.isStarted ? "pause.fill" : stopWatchManager.isPaused ? "arrow.clockwise" : "play.fill")
                    Text(stopWatchManager.isStarted ? "Pause" : stopWatchManager.isPaused ? "Restart" : "Go" )
                }
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(stopWatchManager.isStarted ? .red : .orange)
                .cornerRadius(30)
                .padding(.leading , stopWatchManager.isPaused ? 0 : 125)
                .padding( .trailing , stopWatchManager.isPaused ? 30 : 125)
            }
            
        }
        .padding(.bottom, 30)
        .onAppear(perform: {
            locationManager.delegate = locationViewModel
            locationManager.requestWhenInUseAuthorization()
        })
        .alert(isPresented: $locationViewModel.permissionDenied, content: {
            Alert(title: Text("Permission Denied"), message: Text("Please enable permission to use location."), dismissButton: .default(Text("Goto settings"), action: {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }))
        })
        
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
            .environmentObject(WorkoutViewModel())
    }
}
