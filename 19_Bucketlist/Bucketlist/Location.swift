//
//  Location.swift
//  Bucketlist
//
//  Created by Sonja Ek on 11.11.2022.
//

import Foundation
import CoreLocation

struct Location: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = Location(id: UUID(), name: "Buckingham Palace", description: "Where Queen Elizabeth lived with her dorgis 😢", latitude: 51.501, longitude: -0.141)
}
