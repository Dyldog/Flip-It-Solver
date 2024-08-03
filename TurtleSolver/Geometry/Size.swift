//
//  Size.swift
//  TurtleSolver
//
//  Created by Dylan Elliott on 3/8/2024.
//

import Foundation

struct Size {
    let width: Int
    let height: Int
    
    var positions: [Position] {
        rows.flatMap { $0 }
    }
    
    var rows: [[Position]] {
        (0 ..< height).map { y in
            (0 ..< width).map { x in
                .init(x: x, y: y)
            }
        }
    }
}
