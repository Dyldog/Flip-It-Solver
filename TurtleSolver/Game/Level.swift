//
//  Level.swift
//  TurtleSolver
//
//  Created by Dylan Elliott on 3/8/2024.
//

import Foundation

enum Level {
    static let one: Board.State = [
        [.o, .o, ._, ._],
        [._, ._, ._, .o],
        [._, ._, ._, ._],
        [._, ._, ._, ._]
    ]
    
    static let six: Board.State = [
        [.o, .o, .o, ._],
        [.o, ._, .o, ._],
        [._, ._, ._, ._],
        [._, ._, ._, ._]
    ]
    
    static let seven: Board.State = [
        [._, .o, .o, ._],
        [._, .o, ._, ._],
        [._, .o, ._, ._],
        [._, .o, ._, ._]
    ]
    
    static let twenty: Board.State = [
        [.o, .o, ._, .o],
        [._, .o, ._, ._],
        [._, ._, ._, ._],
        [._, .o, ._, ._]
    ]
    
    static let thirty: Board.State = [
        [.o, ._, ._, .o],
        [._, .o, .o, ._],
        [._, .o, .o, ._],
        [.o, ._, ._, .o]
    ]
    
    static let forty: Board.State = [
        [.o, .o, .o, .o],
        [.o, .o, .o, .o],
        [.o, .o, ._, .o],
        [.o, .o, .o, .o],
    ]
}
