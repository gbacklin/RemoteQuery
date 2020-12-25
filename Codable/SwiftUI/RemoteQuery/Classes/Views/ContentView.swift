//
//  ContentView.swift
//  RemoteQuery
//
//  Created by Gene Backlin on 12/24/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var personManager: PersonQueryManager

    var body: some View {
        NavigationView {
            VStack {
                Text("Query Result")
                Text("\(personManager.objects.count) persons found.")
                if personManager.objects.count > 0 {
                    NavigationLink(destination: DetailView()) {
                        VStack (alignment: .leading) {
                            Text("Tap to show detail")
                            .padding()
                        }
                    }
                } else {
                    Text("Fetching...")
                        .padding()
                }
            }
            .navigationBarTitle("Home")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
