//
//  PinterestLayout.swift
//  PinterestSampleProject
//
//  Created by Woody Lee on 2023/02/08.
//

import SwiftUI

struct ImageModel: Hashable, Identifiable {
    let id = UUID()
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

struct PinterestLayout: View {
    
    private let columns: Int = 2
    
    @State var images: [ImageModel]
    
    @State private var loaded: Bool = false
    
    @State private var gridHeight: CGFloat = 20 // 초기값이 0이면 이미지 크기가 정해지지 않는 이슈
    
    @State private var alignmentGuides = [AnyHashable: CGPoint]() {
        didSet { loaded = !oldValue.isEmpty }
    }
    
    init(images: [ImageModel]) {
        self.images = images
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                GeometryReader { geometry in
                    ZStack(alignment: .topLeading) {
                        ForEach(images, id: \.id) { model in
                            Image(model.name)
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width / 2)
                                .background(reader(id: model.id))
                                .alignmentGuide(.top, computeValue: { _ in self.alignmentGuides[model.id]?.y ?? 0 })
                                .alignmentGuide(.leading, computeValue: { _ in self.alignmentGuides[model.id]?.x ?? 0 })
                        }
                    }
                    .animation(.default, value: self.loaded)
                    .onPreferenceChange(ImageSizePreferenceKey.self) { preferences in
                        DispatchQueue.global(qos: .background).async {
                            let (alignmentGuides, gridHeight) = alignmentGuidsAndGridHeights(preferences: preferences)
                            
                            DispatchQueue.main.async {
                                self.alignmentGuides =  alignmentGuides
                                self.gridHeight = gridHeight
                            }
                        }
                    }
                }
            }.frame(height: gridHeight)
        }
    }
    
    @ViewBuilder
    private func reader(id: AnyHashable) -> some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: ImageSizePreferenceKey.self, value: [ImageData(id: AnyHashable(id), size: geometry.size)])
        }
    }
    
    private func alignmentGuidsAndGridHeights(preferences: [ImageData]) -> ([AnyHashable: CGPoint], CGFloat) {
        var heights = Array(repeating: CGFloat(0), count: self.columns)
        var alignmentsGuides = [AnyHashable: CGPoint]()
        
        preferences.forEach { preference in
            if let minValue = heights.min(), let indexMin = heights.firstIndex(of: minValue) {
                let itemWidth = preference.size.width
                let itemHeight = preference.size.height
                let xPosition = itemWidth * CGFloat(indexMin)
                let yPosition = heights[indexMin]
                let offset = CGPoint(x: 0 - xPosition,
                                     y: 0 - yPosition)
                print(offset, itemHeight)
                heights[indexMin] += itemHeight
                alignmentsGuides[preference.id] = offset
            }
        }
        
        let gridHeight = max(0, heights.max() ?? 0)
        return (alignmentsGuides, gridHeight)
    }
}
