//
//  MissionView.swift
//  Moonshot
//
//  Created by Sonja Ek on 15.10.2022.
//

import SwiftUI

struct Divider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}

struct CrewView: View {
    let crew: [CrewMember]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )
                                .accessibilityHidden(true)

                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                Text(crewMember.role)
                                    .foregroundColor(.secondary)
                            }
                            .accessibilityElement()
                            .accessibilityLabel(crewMember.astronaut.name)
                            .accessibilityHint(crewMember.role)
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

struct MissionView: View {
    let mission: Mission
    let crew: [CrewMember]

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: geometry.size.width * 0.6)
                            .padding(.top)
                            .padding(.bottom)
                            .accessibilityHidden(true)

                        Text("Launch date: \(mission.formattedLaunchDate)")
                            .font(.headline)

                        VStack(alignment: .leading) {
                            Divider()

                            Text("Mission Highlights")
                                .font(.title.bold())
                                .padding(.bottom, 5)

                            Text(mission.description)

                            Divider()

                            Text("Crew")
                                .font(.title.bold())
                                .padding(.bottom, 5)
                        }
                        .padding(.horizontal)

                        CrewView(crew: crew)
                    }
                    .padding(.bottom)
                }
            }
            .navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
        }
    }

    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission

        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}


struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
