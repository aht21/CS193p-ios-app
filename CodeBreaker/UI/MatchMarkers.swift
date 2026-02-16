//
//  MatchMarkers.swift
//  CodeBreaker
//
//  Created by aht21 on 31.01.2026.
//

import SwiftUI

enum Match {
    case nomatch
    case exact
    case inexact
}

struct MatchMarkers: View {
    // MARK: Data In
    let matches: [Match]
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            VStack {
                matchMarker(peg: 0)
                matchMarker(peg: 1)
            }
            VStack {
                matchMarker(peg: 2)
                matchMarker(peg: 3)
            }
            VStack {
                matchMarker(peg: 4)
                matchMarker(peg: 5)
            }
        }
    }
    
    func matchMarker(peg: Int) -> some View {
        let exactCount = matches.count {$0 == .exact}
        let foundCount = matches.count {$0 != .nomatch}
        return Circle()
            .fill(exactCount > peg ? Color.primary : Color.clear)
            .strokeBorder(foundCount > peg ? Color.primary : Color.clear, lineWidth: 2)
            .aspectRatio(1, contentMode: .fit)
    }
}

struct MatchMarkersPreview: View {
    var mainCirclesCount: Int
    var matches: [Match]
    
    var body: some View {
        HStack {
            ForEach(0..<mainCirclesCount, id: \.self) { _ in
                Circle()
            }
            Rectangle().foregroundStyle(Color.clear).aspectRatio(1, contentMode: .fit)
                .overlay() {
                    MatchMarkers(matches: matches)
                }
        }
        .frame(alignment: .leading)
        .padding()
    }
}

#Preview {
//    MatchMarkers(matches: [.exact, .inexact, .nomatch])
    VStack {
        MatchMarkersPreview(mainCirclesCount: 3, matches: [.exact, .inexact, .nomatch, .exact, .inexact, .inexact])
        MatchMarkersPreview(mainCirclesCount: 4, matches: [.exact, .inexact, .nomatch, .exact])
        MatchMarkersPreview(mainCirclesCount: 6, matches: [.exact, .exact, .exact, .inexact, .inexact, .nomatch])
        MatchMarkersPreview(mainCirclesCount: 5, matches: [.exact, .inexact, .nomatch, .exact])
    }
    .padding()
}
