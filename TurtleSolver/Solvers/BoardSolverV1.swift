//
//  BoardSolver.swift
//  TurtleSolver
//
//  Created by Dylan Elliott on 3/8/2024.
//

import Foundation

class BoardSolverV1 {
    typealias PartialSolution = Solution
    
    let debug: Bool
    let initialBoard: Board
    var checkedIDs: [String]
    
    let positions: [Position]
    
    init(_ board: Board, debug: Bool = false) {
        self.debug = debug
        self.initialBoard = board
        self.positions = board.size.positions
        self.checkedIDs = [board.id]
    }
    
    func solve() throws -> [[Move]] {
        try checkPositions(in: initialBoard, with: [])
    }
    
    private func checkPositions(in board: Board, with history: PartialSolution) throws -> [Solution] {
        var foundSolutions: [Solution] = []
        for position in positions {
            if let cell = board.cell(at: position), cell.isNotEmpty {
                for direction in Direction.allCases {
                    do {
                        var newBoard = board
                        let newPosition = try newBoard.moveTurtle(at: position, in: direction)
                        let newHistory = history + [(position, direction)]
                        
                        if checkedIDs.contains(newBoard.id) {
                            continue
                        } else {
                            checkedIDs.append(newBoard.id)
                        }
                        
                        if debug {
                            print("""
                            Making move from...
                            
                            \(board.description)
                            
                            To...

                            \(newBoard.description)
                            """)
                        }
                        
                        if newBoard.isSolved {
                            foundSolutions.append(newHistory)
                        } else {
                            foundSolutions.append(
                                contentsOf: try checkPositions(in: newBoard, with: newHistory)
                            )
                        }
                    } catch is Board.MoveError, is Cell.Error {
                        //
                    } catch {
                        throw error
                    }
                }
            }
        }
        
        return foundSolutions
    }
}
