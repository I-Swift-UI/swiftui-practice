//
//  Photos.swift
//  PinterestSampleProject
//
//  Created by Woody Lee on 2023/02/08.
//

import SwiftUI

struct Photos: View {
    var body: some View {
        NavigationStack {
            PinterestLayout(images: ImageFactory.random().map { .init(name: $0)})
                .navigationTitle("사진")
        }
    }
}

struct Photos_Previews: PreviewProvider {
    static var previews: some View {
        Photos()
    }
}
