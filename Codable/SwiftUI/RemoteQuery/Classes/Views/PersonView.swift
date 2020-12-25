//
//  PersonView.swift
//  RemoteQuery
//
//  Created by Gene Backlin on 12/24/20.
//

import SwiftUI

struct PersonView: View {
    var person: Person
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Hometown: \(person.Hometown)")
                Text("Age: \(person.Age)")
                Text("Job: \(person.Job)")
            }
            .navigationBarTitle("\(person.Firstname) \(person.Lastname)")
            .padding()
            Spacer()
        }
    }
}
