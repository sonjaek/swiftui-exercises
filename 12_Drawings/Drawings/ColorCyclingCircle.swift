//
//  ColorCyclingCircle.swift
//  Drawings
//
//  Created by Sonja Ek on 20.10.2022.
//

import SwiftUI

struct ColorCyclingCircleView: View {
    var amount = 0.0
    var steps = 100

    var body: some View {
        ZStack {
            ForEach(0 ..< steps) { value in
                Circle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup()
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ColorCyclingCircle: View {
    @State private var colorCycle = 0.0

    var body: some View {
        NavigationView {
            VStack {
                ColorCyclingCircleView(amount: colorCycle)
                    .frame(width: 300, height: 300)

                Slider(value: $colorCycle)

                NavigationLink {
                    ColorCyclingRectangle()
                } label: {
                    Text("Switch to Rectangle")
                        .padding()
                }
            }
        }
    }
}


struct ColorCyclingCircle_Previews: PreviewProvider {
    static var previews: some View {
        ColorCyclingCircle()
    }
}
