//
//  ContentView.swift
//  LayoutSampleProject
//
//  Created by Jaeyong on 2023/01/26.
//

import SwiftUI

struct BoxView: View {
    static let radius: CGFloat = 20
    let width: CGFloat
    let height: CGFloat
    
    init(size: CGSize) {
        self.width = size.width
        self.height = size.height
    }
    
    init(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.yellow
            VStack {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 3) {
                        Text("8,652원")
                        Text("카카오페이머니")
                    }
                    .padding(10)
                    .font(.caption)
                    .fontWeight(.bold)
                    
                    Spacer()
                    HStack {
                        Spacer()
                        Image(systemName: "checkmark")
                    }
                    .padding(10)
                }
            }
        }
        .frame(width: width, height: height)
        .cornerRadius(Self.radius)
    }
}

struct AnimateView: View {
    var spacing: CGFloat
    var width: CGFloat
    var height: CGFloat
    
    @Binding var animate: Bool
    
    var body: some View {
        VStack(spacing: animate ? 0 : spacing) {
            HStack(spacing: animate ? 0 : spacing) {
                BoxView(size: growingBoxSize())
                BoxView(size: shrinkingBoxSize())
            }
            HStack(spacing: animate ? 0 : spacing) {
                BoxView(size: shrinkingBoxSize())
                BoxView(size: shrinkingBoxSize())
            }
        }
        .frame(width: 2*width+GridView.spacing, height: 2*height+GridView.spacing)
    }
    
    private func shrinkingBoxSize() -> CGSize {
        animate ? .zero : .init(width: width, height: height)
    }
    
    private func growingBoxSize() -> CGSize {
        animate ? .init(width: 2*width+spacing, height: 2*height+spacing) : .init(width: width, height: height)
    }
}

struct GridView: View {
    static let spacing: CGFloat = 10
    
    @Binding var animate: Bool
    
    var width: CGFloat
    var height: CGFloat

    var body: some View {
        layout()
    }
    
    @ViewBuilder
    private func layout() -> some View {
        VStack(spacing: Self.spacing) {
            HStack(spacing: Self.spacing) {
                AnimateView(spacing: Self.spacing, width: width, height: height, animate: $animate)
                VStack(spacing: Self.spacing) {
                    BoxView(width: width, height: height)
                    BoxView(width: width, height: height)
                }
            }
            HStack(spacing: Self.spacing) {
                BoxView(width: width, height: height)
                BoxView(width: width, height: height)
                BoxView(width: width, height: height)
            }
        }
        .animation(.linear, value: animate)
    }
}

struct ContentView: View {
    static let inset: CGFloat = 16
    
    @State var changableLayout: Bool = false
    
    var body: some View {
        VStack {
            GeometryReader { geometryProxy in
                gridView(geometry: geometryProxy)
                    .padding(Self.inset)
            }
            Spacer()
            Button("눌러보자") {
                changableLayout.toggle()
                print(changableLayout)
            }
        }
    }
    
    private func gridView( geometry: GeometryProxy) -> some View {
        let itemWidth: CGFloat = (geometry.size.width - ContentView.inset * 2 - GridView.spacing * 2) / 3
        let itemHeight: CGFloat = itemWidth*5/4
        return GridView(animate: $changableLayout,
                        width: itemWidth,
                        height: itemHeight)
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
//        BoxView(width: 120, height: 120, radius: 20)
        ContentView()
    }
}
