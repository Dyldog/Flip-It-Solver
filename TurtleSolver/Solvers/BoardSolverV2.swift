//
//  BoardSolverV2.swift
//  TurtleSolver
//
//  Created by Dylan Elliott on 3/8/2024.
//

import Foundation

class BoardSolverV2 {
    typealias PartialSolution = Solution
    typealias IntermetiateSolution = (Board, PartialSolution)
    
    let debug: Bool
    let initialBoard: Board
    var checkedBoards: Set<Board>
    
    let positions: [Position]
    
    init(_ board: Board, debug: Bool = false) {
        self.debug = debug
        self.initialBoard = board
        self.positions = board.size.positions
        self.checkedBoards = [board]
    }
    
    
    func solve() throws -> [Solution] {
        var solutions: [Solution] = []
        var boards: [IntermetiateSolution] = [(initialBoard, [])]
        
        var i: Int = -1
        
        while !boards.isEmpty {
            i += 1
            print("Checking at depth \(i) with \(boards.count) boards...")
            
            var next: [(Board, [Move])] = []
            
            for (boardIdx, board) in boards.enumerated() {
                let newBoards = try nextBoards(from: board.0, with: board.1)
                
                for (newIdx, newBoard) in newBoards.enumerated() {
                    print("\(i): \(boardIdx)/\(boards.count) - \(newIdx)/\(newBoards.count)")
                    guard !checkedBoards.contains(newBoard.0) else { continue }
                    
                    checkedBoards.insert(newBoard.0)
                    
                    if newBoard.0.isSolved {
                        solutions.append(newBoard.1)
                        return solutions
                    } else {
                        next.append(newBoard)
                    }
                }
            }
            
            boards = next
        }
        
        return solutions
    }
    
    private func nextBoards(from board: Board, with history: PartialSolution) throws -> [IntermetiateSolution] {
        try positions.flatMap { position in
            guard let cell = board.cell(at: position), cell.isNotEmpty else { return [IntermetiateSolution]() }

            return try Direction.allCases.compactMap { direction in
                var newBoard = board
                do {
                    _ = try newBoard.moveTurtle(at: position, in: direction)
                    return (newBoard, history + [(position, direction)])
                } catch is Board.MoveError, is Cell.Error {
                    return nil
                } catch {
                    throw error
                }
            }
        }
    }
}
