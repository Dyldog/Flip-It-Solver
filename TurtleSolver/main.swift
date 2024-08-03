//
//  main.swift
//  TurtleSolver
//
//  Created by Dylan Elliott on 3/8/2024.
//

import Foundation

do {
    let board = try Board(Level.forty)
    
    let solver = BoardSolverV2(board, debug: false)
    let solutions = try solver.solve()
    
    if let solution = solutions.sorted(by: { $0.count < $1.count}).last {
        try print(solution.description(from: board))
    } else {
        print("👎 No solution 👎")
    }
} catch {
    print(error.localizedDescription)
}

extension Int {
    var userFriendly: Int { self + 1 }
}
