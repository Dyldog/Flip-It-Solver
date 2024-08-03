//
//  Solution.swift
//  TurtleSolver
//
//  Created by Dylan Elliott on 3/8/2024.
//

import Foundation

typealias Move = (Position, Direction)
typealias Solution = [Move]

extension Solution {
    private func stepsDescription(from board: Board) throws -> String {
        try reduce((board: board, steps: [String]())) { (previous, step) in
            var newBoard = previous.board
            let newPostion = step.0 + step.1.direction
            
            _ = try newBoard.moveTurtle(at: step.0, in: step.1)
            
            return (newBoard, previous.steps + ["""
            (\(step.0.x), \(step.0.y))(\(step.1.code)) -> (\(newPostion.x), \(newPostion.y))
            \(newBoard.description)
            """])
        }
        .steps.joined(separator: "\n\n")
    }
    func description(from board: Board) throws -> String {
        return """
        Got solution in \(count) moves...
        
        \(board.description)
        
        \(try stepsDescription(from: board))
        """
    }
}
