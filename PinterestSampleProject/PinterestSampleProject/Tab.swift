//
//  Tab.swift
//  PinterestSampleProject
//
//  Created by Woody Lee on 2023/02/08.
//

import SwiftUI

enum Tab: CaseIterable {
    case photos
    case likes
    
    var imageSystemName: String {
        switch self {
        case .photos: return "photo.fill"
        case .likes: return "hare.fill"
        }
    }
    
    var title: String {
        switch self {
        case .photos: return "사진"
        case .likes: return "좋아요"
        }
    }
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .photos: Photos()
        case .likes: Likes()
        }
    }
}
