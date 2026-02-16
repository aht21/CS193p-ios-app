//
//  PegView.swift
//  CodeBreaker
//
//  Created by aht21 on 08.02.2026.
//

import SwiftUI

struct PegView: View {
    // MARK: Data In
    let peg: Peg
    let mode: PegMode
    
    // MARK: - Body
    
    let pegShape = Circle()
    
    var body: some View {
        ZStack {
            if peg == Code.missingPeg {
                pegShape
                    .strokeBorder(Color.gray, lineWidth: 2)
                    .aspectRatio(1, contentMode: .fit)
            } else {
                if mode == .emoji {
                    Text(peg)
                       .font(.system(size: 40))
                       .frame(maxWidth: .infinity, maxHeight: .infinity)
                       .aspectRatio(1, contentMode: .fit)
                } else {
                    pegShape
                       .fill(Color(hex: peg))
                       .aspectRatio(1, contentMode: .fit)
                }
            }
        }
        .contentShape(pegShape)
    }
}

#Preview {
    PegView(peg: "000000", mode: .color)
        .padding()
}
