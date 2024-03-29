//
//  GeometryReaderScrollView.swift
//  LayoutAndGeometry
//
//  Created by Sonja Ek on 15.12.2022.
//

import SwiftUI

struct HelixScrollView: View {
    var body: some View {
        Text("Scroll me vertically")
            .font(.headline)
        GeometryReader { fullView in
            ScrollView {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(Color(hue: min(1, geo.frame(in: .global).minY / fullView.size.height), saturation: 1, brightness: 1))
                            .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .opacity(geo.frame(in: .global).minY / 200)
                            .scaleEffect(max(0.5, geo.frame(in: .global).minY / 400))
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

struct HorizontalScrollView: View {
    var body: some View {
        Text("Scroll me horizontally")
            .font(.headline)
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(1..<20) { num in
                    GeometryReader { geo in
                        Text("Number \(num)")
                            .font(.largeTitle)
                            .padding()
                            .background(.red)
                            .rotation3DEffect(.degrees(-geo.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
                            .frame(width: 200, height: 100)
                    }
                    .frame(width: 200, height: 100)
                }
            }
        }
    }
}

struct GeometryReaderScrollView: View {
    var body: some View {
        VStack {
            HelixScrollView()
            Divider()
            HorizontalScrollView()
        }
    }
}

struct GeometryReaderScrollView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderScrollView()
    }
}
