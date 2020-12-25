//
//  DetailView.swift
//  RemoteQuery
//
//  Created by Gene Backlin on 12/24/20.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var personQuery: PersonQueryManager

    var body: some View {
        List(personQuery.objects) { person in
            NavigationLink(destination: PersonView(person: person)) {
                VStack (alignment: .leading) {
                    Text(person.Lastname)
                    Text(person.Firstname)
                        .font(.system(size: 11))
                        .foregroundColor(Color.gray)
                }
            }
            .navigationBarTitle("Details")
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
