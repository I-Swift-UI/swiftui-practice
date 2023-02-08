//
//  ContentView.swift
//  PinterestSampleProject
//
//  Created by Woody Lee on 2023/02/08.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ForEach(Tab.allCases, id: \.self) { tab in
                tab.view
                    .tabItem {
                        Image(systemName: tab.imageSystemName)
                        Text(tab.title)
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
