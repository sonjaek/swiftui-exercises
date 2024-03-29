//
//  DynamicFilteringView.swift
//  CoreDataProject
//
//  Created by Sonja Ek on 1.11.2022.
//

import SwiftUI

struct DynamicFilteringView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"

    var body: some View {
        VStack {
            FilteredList(filterKey: "lastName", filterValue: lastNameFilter, predicate: .beginsWith) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }

            Button("Add Examples") {
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"

                let ed = Singer(context: moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"

                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"

                try? moc.save()
            }

            Button("Show A") {
                lastNameFilter = "A"
            }

            Button("Show S") {
                lastNameFilter = "S"
            }
        }
    }
}

struct DynamicFilteringView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicFilteringView()
    }
}
