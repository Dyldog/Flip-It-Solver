//
//  Position.swift
//  TurtleSolver
//
//  Created by Dylan Elliott on 3/8/2024.
//

import Foundation

struct Position {
    let x: Int
    let y: Int
    
    static func +(lhs: Position, rhs: Position) -> Position {
        .init(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    func isWithin(_ size: Size) -> Bool {
        x >= 0 && x < size.width && y >= 0 && y < size.height
    }
}

