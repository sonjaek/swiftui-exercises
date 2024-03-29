//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sonja Ek on 17.9.2022.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.white)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct ContentView: View {
    @State private var score = 0
    @State private var showingScore = false
    @State private var selectedFlag: Int?
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var questionsAsked = 0
    @State private var gameOver = false

    @State private var animationAmount = 0.0
    @State private var opacityAmount = 1.0
    @State private var sizeAnimationAmount = 1.0

    struct FlagImage: View {
        var country: String

        var body: some View {
            let labels = [
                "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
                "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
                "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
                "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
                "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
                "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
                "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
                "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
                "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
                "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
                "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
            ]

            Image(country)
                .renderingMode(.original)
                .clipShape(Capsule())
                .shadow(radius: 5)
                .accessibilityLabel(labels[country, default: "Unknown flag"])
        }
    }

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()

            VStack {
                Spacer()
                Text("Guess the Flag")
                    .titleStyle()

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }

                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(country: countries[number])
                        }
                        .rotation3DEffect(.degrees(selectedFlag == number ? animationAmount : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(selectedFlag == number ? 1 : opacityAmount)
                        .scaleEffect(selectedFlag == number ? 1 : sizeAnimationAmount)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())

                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert(scoreTitle, isPresented: $gameOver) {
            Button("Play again", action: reset)
        } message: {
                Text("Game over! Your final score is \(score).")
        }
    }

    func flagTapped(_ number: Int) {
        selectedFlag = number

        withAnimation {
            animationAmount += 360
            opacityAmount = 0.25 * opacityAmount
            sizeAnimationAmount -= 0.5
        }

        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong! That was the flag of \(countries[number])"
        }

        questionsAsked += 1

        if questionsAsked == 8 {
            gameOver = true
        } else {
            showingScore = true
        }
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        animationAmount = 0.0
        opacityAmount = 1.0
        sizeAnimationAmount = 1.0
    }

    func reset() {
        questionsAsked = 0
        score = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
