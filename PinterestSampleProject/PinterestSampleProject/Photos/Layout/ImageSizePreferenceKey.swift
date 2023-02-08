//
//  ImageSizePreferenceKey.swift
//  PinterestSampleProject
//
//  Created by Woody Lee on 2023/02/08.
//

import SwiftUI

struct ImageData: Equatable {
    let id: AnyHashable
    let size: CGSize
}

struct ImageSizePreferenceKey: PreferenceKey {
    typealias Value = [ImageData]
    
    static var defaultValue: [ImageData] = []
    
    static func reduce(value: inout [ImageData], nextValue: () -> [ImageData]) {
        value.append(contentsOf: nextValue())
    }
}
