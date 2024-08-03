//
//  Cell.swift
//  TurtleSolver
//
//  Created by Dylan Elliott on 3/8/2024.
//

import Foundation

struct Cell {
    enum Error: Swift.Error {
        case cantFlipEmptyCell
    }
    
    let position: Position
    var state: CellState
    
    init(position: Position, state: CellState) {
        self.position = position
        self.state = state
    }
    
    var isEmpty: Bool { state == .empty }
    var isNotEmpty: Bool { state != .empty }
    
    mutating func flip() throws {
        switch state {
        case .empty: throw Error.cantFlipEmptyCell
        case .unflipped: state = .flipped
        case .flipped: state = .unflipped
        }
    }
}
