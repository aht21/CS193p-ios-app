//
//  CodeView.swift
//  CodeBreaker
//
//  Created by aht21 on 09.02.2026.
//

import SwiftUI

struct CodeView: View {
    // MARK: Data In
    let code: Code
    let mode: PegMode

    // MARK: Data Shared with Me
    @Binding var selection: Int

    // MARK: - Body

    var body: some View {
        ForEach(code.pegs.indices, id: \.self) { index in
            peg(at: index)
        }
    }

    private func peg(at index: Int) -> some View {
        PegView(peg: code.pegs[index], mode: mode)
            .padding(Selection.border)
            .background {
                selectionBackground(for: index)
            }
            .overlay {
                hiddenOverlay
            }
            .onTapGesture {
                handleTap(at: index)
            }
    }

    @ViewBuilder
    private func selectionBackground(for index: Int) -> some View {
        if selection == index, code.kind == .guess {
            RoundedRectangle(cornerRadius: Selection.cornerRadius)
                .foregroundStyle(Selection.color)
        }
    }

    private var hiddenOverlay: some View {
        Selection.shape
            .foregroundStyle(code.isHidden ? Color.gray : .clear)
    }

    private func handleTap(at index: Int) {
        guard code.kind == .guess else { return }
        selection = index
    }

    struct Selection {
        static let border: CGFloat = 5
        static let cornerRadius: CGFloat = 10
        static let color: Color = Color.gray(0.85)
        static let shape = RoundedRectangle(cornerRadius: cornerRadius)
    }
}
