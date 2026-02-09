//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by aht21 on 31.01.2026.
//

import SwiftUI

enum PegMode {
    case emoji
    case color
}

struct CodeBreakerView: View {
    // MARK:  Data Owned by Me
    @State private var mode: PegMode
    @State private var game: CodeBreaker
    @State private var selection: Int = 0
 
    init() {
        let (randomMode, pegSet) = randomizeModeAndPegs()
        _mode = State(initialValue: randomMode)
        _game = State(initialValue: CodeBreaker(pegChoices: pegSet))
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            restartButton
            view(for: game.masterCode)
            ScrollView {
                if !game.isOver {
                    view(for: game.guess)
                }
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    view(for: game.attempts[index])
                }
            }
            PegChooser(mode: mode, choices: game.pegChoices) { peg in
                game.setGuessPeg(peg, at: selection)
                selection = (selection + 1) % game.masterCode.pegs.count
            }
        }
        .padding()
        
    }
    
    var guessButton: some View {
        Button("Guess") {
            withAnimation {
                game.attemptGuess()
                selection = 0
            }
        }
        .font(.system(size: GuessButton.maximumFontSize))
        .minimumScaleFactor(GuessButton.scaleFactor)
    }
    
    var restartButton: some View {
        Button("Restart") {
            withAnimation {
                let (newMode, pegSet) = randomizeModeAndPegs()
                mode = newMode
                game = CodeBreaker(pegChoices: pegSet)
            }
        }
        .font(.system(size: 24))
    }
    
    func view(for code: Code) -> some View {
        HStack {
            CodeView(code: code, mode: mode, selection: $selection)
            
            Rectangle().foregroundStyle(Color.clear).aspectRatio(1, contentMode: .fit)
                .overlay {
                    if let matches = code.matches {
                        MatchMarkers(matches: matches)
                    } else {
                        if code.kind == .guess {
                            guessButton
                        }
                    }
                }
        }
    }
    
    struct GuessButton {
        static let minimumFontSize: CGFloat = 8
        static let maximumFontSize: CGFloat = 50
        static let scaleFactor = minimumFontSize / maximumFontSize
    }
    
    struct Selection {
        static let border: CGFloat = 5
        static let cornerRadius: CGFloat = 10
        static let color: Color = Color.gray(0.85)
    }

}

func randomizeModeAndPegs() -> (PegMode, [Peg]) {
    let mode: PegMode = Bool.random() ? .emoji : .color
    let pegs: [Peg]
    switch mode {
    case .emoji:
        pegs = ["🍎", "🍌", "🍇", "🥝"]
    case .color:
        pegs = ["FF0000", "00FF00", "0000FF", "FFFF00"]
    }
    return (mode, pegs)
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
    
    static func gray(_ brightness: CGFloat) -> Color {
        return Color(hue: 148/360, saturation: 0, brightness: brightness)
    }
}

#Preview {
    CodeBreakerView()
}
