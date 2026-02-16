//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by aht21 on 04.02.2026.
//

import Foundation

typealias Peg = String

struct CodeBreaker {
    var masterCode: Code
    var guess: Code
    var attempts: [Code] = []
    let pegChoices: [Peg]
    let pegsCount: Int
    
    init(pegChoices: [Peg]) {
        self.pegsCount = Int.random(in: 3...6)
        self.masterCode = Code(kind: .master(isHidden: true), pegsCount: pegsCount)
        self.guess = Code(kind: .guess, pegsCount: pegsCount)
        self.pegChoices = pegChoices
        
        masterCode.randomize(from: pegChoices)
        
        print(masterCode)
    }
    
    var isOver: Bool {
        attempts.last?.pegs == masterCode.pegs
    }
    
    mutating func attemptGuess() {
        guard !guess.pegs.allSatisfy({ $0 == Code.missingPeg }) else { return }
        guard !attempts.contains(where: { $0.pegs == guess.pegs }) else { return }

        var attempt = guess
        attempt.kind = .attempt(guess.match(against: masterCode))
        attempts.append(attempt)
        guess.reset(pegsCount: self.pegsCount)
        
        if isOver {
            masterCode.kind = .master(isHidden: false)
        }
    }
    
    mutating func setGuessPeg(_ peg: Peg, at index: Int) {
        guard guess.pegs.indices.contains(index) else { return }
        guess.pegs[index] = peg
    }
    
    mutating func changeGuessPeg(at index: Int) {
        let existingPeg = guess.pegs[index]
        if let indexOfExistingPegInPegChoices = pegChoices.firstIndex(of: existingPeg) {
            let newPeg = pegChoices[(indexOfExistingPegInPegChoices + 1) % pegChoices.count]
            guess.pegs[index] = newPeg
        } else {
            guess.pegs[index] = pegChoices.first ?? Code.missingPeg
        }
    }
}
