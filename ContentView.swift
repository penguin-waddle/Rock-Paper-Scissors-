import SwiftUI

struct ButtonDesign: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 100, height: 70, alignment: .center)
            .foregroundColor(.white)
            .background(Color.black)
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .cornerRadius(15)
    }
}

extension View {
    func buttonDesign() -> some View {
        modifier(ButtonDesign())
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var moves = ["Rock","Paper","Scissors"]
    @State private var shouldWin = true
    @State private var choice = "Paper"
    
    func nextRound() {
        choice = moves[Int.random(in: 0...2)]
        shouldWin = Bool.random()
    }
    
    @State private var userScore = 0
    @State private var endGame = false
    @State private var numberOfTaps = 1
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 2, green: 0.1, blue: 0.9), location: 0.5),
                .init(color: Color(red: 0.4, green: 0.6, blue: 0.9), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Rock, Paper, Scissors!")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                Spacer()
                Spacer()
                Text("I chose \(choice).")
                     .font(.system(size: 25, weight: .bold, design: .rounded))

                VStack (spacing: 10) {
                    VStack {
                        Spacer()
                        Text("Choose your move.")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        shouldWin ? Text("Try to win!") : Text("Try to lose!")
                        }
                        Spacer()
                    
                    Button(action: {
                        rockWasSelected()
                    }) {
                        Text("\(moves[0])")
                            .buttonDesign()
                    }
                    // Paper selection
                    Button(action: {
                        paperWasSelected()
                    }) {
                        Text("\(moves[1])")
                            .buttonDesign()
                    }
                    // Scissors selection
                    Button(action: {
                        scissorsWasSelected()
                    }) {
                        Text("\(moves[2])")
                            .buttonDesign()
                    }
                    }
                Spacer()
                Text("Score: \(userScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
                
                } 
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
               
            } 
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: nextRound)
            } message: {
                Text("Your score is \(userScore).")
            }
            .alert(scoreTitle, isPresented: $endGame) {
                Button("Restart Game", action: reset)
            } message: {
                Text("Your final score is \(userScore).")
            }
    }
    func rockWasSelected() {
        if choice == moves[2] && shouldWin || choice == moves[1] && !shouldWin {
            userScore += 1
            scoreTitle = "You Won :)"
        } else if choice == moves[0] && shouldWin || choice == moves[0] && !shouldWin {
            userScore += 0
            scoreTitle = "We're equal :/"
        } else {
            userScore -= 1
            scoreTitle = "You lost :("
        }
        showingScore = true
        numberOfTaps += 1
        
        if numberOfTaps == 10 {
            showingScore = false
            endGame = true
        }
    }
    
    // game logic when Paper is selected
    func paperWasSelected() {
        if choice == moves[0] && shouldWin || choice == moves[2] && !shouldWin {
            userScore += 1
            scoreTitle = "You Won :)"
        } else if choice == moves[1] && shouldWin || choice == moves[1] && !shouldWin {
            userScore += 0
            scoreTitle = "We're equal :/"
        } else {
            userScore -= 1
            scoreTitle = "You lost :("
        }
        showingScore = true
        numberOfTaps += 1
        
        if numberOfTaps == 10 {
            showingScore = false
            endGame = true
        }
    }
    
    // game logic when Scissors is selected
    func scissorsWasSelected() {
        if choice == moves[1] && shouldWin || choice == moves[0] && !shouldWin {
            userScore += 1
            scoreTitle = "You Won :)"
        } else if choice == moves[2] && shouldWin || choice == moves[2] && !shouldWin {
            userScore += 0
            scoreTitle = "We're equal :/"
        } else {
            userScore -= 1
            scoreTitle = "You lost :("
        }
        showingScore = true
        numberOfTaps += 1
        
        if numberOfTaps == 10 {
            showingScore = false
            endGame = true
        }
    }
    
    func reset() {
        nextRound()
        userScore = 0
        numberOfTaps = 0
        shouldWin.toggle()
    }
}

