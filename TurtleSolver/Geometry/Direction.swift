//
//  Direction.swift
//  TurtleSolver
//
//  Created by Dylan Elliott on 3/8/2024.
//

import Foundation

enum Direction: CaseIterable {
    case left
    case upLeft
    case up
    case upRight
    case right
    case rightDown
    case down
    case leftDown
    
    var vector: (x: Int, y: Int) {
        switch self {
        case .left: return (-1, 0)
        case .upLeft: return (-1, -1)
        case .up: return (0, -1)
        case .upRight: return (1, -1)
        case .right: return (1, 0)
        case .rightDown: return (1, 1)
        case .down: return (0, 1)
        case .leftDown: return (-1, 1)
        }
    }
    
    var direction: Position {
        let vector = self.vector
        return .init(x: vector.x, y: vector.y)
    }
    
    var code: String {
        switch self {
        case .left: return "L"
        case .right: return "R"
        case .up: return "U"
        case .down: return "D"
        case .upLeft: return "UL"
        case .upRight: return "UR"
        case .leftDown: return "DL"
        case .rightDown: return "DR"
        }
    }
}
