//
//  CellState.swift
//  TurtleSolver
//
//  Created by Dylan Elliott on 3/8/2024.
//

import Foundation

enum CellState {
    case empty
    case unflipped // Showing orange belly
    case flipped // Showing green shell
    
    static var `_`: CellState { .empty }
    static var o: CellState { .unflipped }
    static var x: CellState { .flipped }
    
    var isEmpty: Bool { self == .empty }
    var isNotEmpty: Bool { self != .empty }
    
    var symbol: String {
        switch self {
        case .empty: return "_"
        case .unflipped: return "o"
        case .flipped: return "x"
        }
    }
    
    var emoji: String {
        switch self {
        case .empty: return "0️⃣"
        case .unflipped: return "❌"
        case .flipped: return "✅"
        }
    }
    
    var code: Int {
        switch self {
        case .empty: return 0
        case .unflipped: return 1
        case .flipped: return 2
        }
    }
}
