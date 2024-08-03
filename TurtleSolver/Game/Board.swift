//
//  Board.swift
//  TurtleSolver
//
//  Created by Dylan Elliott on 3/8/2024.
//

import Foundation

struct Board: Hashable, Equatable {
    typealias State = [[CellState]]
    
    enum SetupError: Swift.Error {
        case stateRowsNotSameLength(row: Int)
        case emptyBoardState
    }
    
    enum MoveError: Swift.Error {
        case attemptToMoveFromOutsideBounds
        case attemptToMoveOutsideBounds
        case attemptToFlipMoreThanTwoTurtles
        case attemptToMoveFromEmptySquare
        case attemptToMoveToFilledSquare
    }
    
    let size: Size
    private var cells: [Cell]
    
    var isSolved: Bool {
        cells.filter { $0.state == .unflipped }.count == 0
    }
    
    init(_ state: State) throws {
        self.size = try Self.checkState(state)
                
        self.cells = self.size.positions.map {
            .init(position: $0, state: state[$0.y][$0.x])
        }
    }
    
    static func checkState(_ state: [[CellState]]) throws -> Size {
        var rowLength: Int?
        
        for (idx, row) in state.enumerated() {
            if let rowLength, row.count != rowLength {
                throw SetupError.stateRowsNotSameLength(row: idx)
            } else {
                rowLength = row.count
            }
        }
        
        guard let rowLength, rowLength > 0 else { throw SetupError.emptyBoardState }
        
        return .init(width: rowLength, height: state.count)
    }
    
    func cell(at position: Position) -> Cell? {
        guard position.isWithin(size) else { return nil }
        return cells[position.y * size.width + position.x]
    }
    
    func adjacentCells(around position: Position) -> [Cell] {
        Direction.allCases.compactMap {
            return cell(at: position + $0.direction)
        }
    }
    
    mutating func moveTurtle(at oldPosition: Position, to newPosition: Position) throws {
        let oldState = cells[oldPosition.y * size.width + oldPosition.x].state
        let newState = cells[newPosition.y * size.width + newPosition.x].state
        
        guard oldState.isNotEmpty else { throw MoveError.attemptToMoveFromEmptySquare }
        guard newState.isEmpty else { throw MoveError.attemptToMoveToFilledSquare }
        
        cells[oldPosition.y * size.width + oldPosition.x].state = .empty
        cells[newPosition.y * size.width + newPosition.x].state = oldState
    }
    
    mutating private func flipTurtle(at position: Position) throws {
        try cells[position.y * size.width + position.x].flip()
    }
    
    mutating func moveTurtle(at position: Position, in direction: Direction) throws -> Position {
        guard cell(at: position) != nil else { throw MoveError.attemptToMoveFromOutsideBounds }
        
        guard let toFlip = cell(at: position + direction.direction) else { throw MoveError.attemptToMoveOutsideBounds }
        
        guard let destination = cell(at: toFlip.position + direction.direction) else { throw MoveError.attemptToMoveOutsideBounds }
        
        if destination.state.isNotEmpty {
            let otherToFlip = destination
            
            guard let destination = cell(at: otherToFlip.position + direction.direction) else { throw MoveError.attemptToMoveOutsideBounds }
            guard destination.isEmpty else { throw MoveError.attemptToFlipMoreThanTwoTurtles }
            
            try moveTurtle(at: position, to: destination.position)
            try flipTurtle(at: toFlip.position)
            try flipTurtle(at: otherToFlip.position)
            
            return destination.position
        } else {
            try moveTurtle(at: position, to: destination.position)
            try flipTurtle(at: toFlip.position)
            
            return destination.position
        }
    }
    
    var description: String {
        size.rows.map { row in
            row.map { cell(at: $0)?.state.emoji ?? "?" }.joined(separator: " ")
        }
        .joined(separator: "\n")
    }
    
    var id: String {
        cells.map { "\($0.state.code)" }.joined()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Board, rhs: Board) -> Bool {
        lhs.id == rhs.id
    }
}
