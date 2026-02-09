//
//  PegChooser.swift
//  CodeBreaker
//
//  Created by aht21 on 09.02.2026.
//

import SwiftUI

struct PegChooser: View {
    // MARK: Data In
    let mode: PegMode
    let choices: [Peg]
    let onChoose: ((Peg) -> Void)?
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            ForEach(choices, id: \.self) { peg in
                Button {
                    onChoose?(peg)
                } label: {
                    PegView(peg: peg, mode: mode)
                }
            }
        }
    }
}

//#Preview {
//    PegChooser()
//}
