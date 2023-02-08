//
//  Likes.swift
//  PinterestSampleProject
//
//  Created by Woody Lee on 2023/02/08.
//

import SwiftUI

struct Likes: View {
    var body: some View {
        NavigationStack {
            Text("Hello, Likes!")
                .navigationTitle("좋아요")
        }
    }
}

struct Likes_Previews: PreviewProvider {
    static var previews: some View {
        Likes()
    }
}
