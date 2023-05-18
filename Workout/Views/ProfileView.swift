//
//  ProfileView.swift
//  Workout
//
//  Created by blind heitz nathan on 03/03/2022.
//

import SwiftUI

struct ProfileView: View {
    
    enum Gender: String, CaseIterable {
        case female, male, other
    }
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var gender: Gender = .female
    @State var dateBirth: Date = Date()
    
    var body: some View {
        NavigationView {
            List {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                Picker("Gender", selection: $gender) {
                    ForEach(Gender.allCases, id: \.self) {
                        Text($0.rawValue.capitalized)
                    }
                }
                .pickerStyle(.segmented)
                DatePicker(selection: $dateBirth, displayedComponents: .date) {
                    Text("Date of birth")
                }
                Button {
                    
                } label: {
                    Text("Save")
                }
            }
            .navigationTitle("Profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
