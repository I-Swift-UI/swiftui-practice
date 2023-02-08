//
//  ImageFactory.swift
//  PinterestSampleProject
//
//  Created by Woody Lee on 2023/02/08.
//

import Foundation

struct ImageFactory {
    static func random() -> [String] {
        Array(0..<22).map { "image\($0)" }.shuffled()
    }
}
