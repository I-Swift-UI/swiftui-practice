//
//  ContentView.swift
//  DataBindingSampleProject
//
//  Created by Jaeyong on 2023/01/30.
//

import SwiftUI

struct Memo: Identifiable {
    typealias ID = UUID
    
    let id: ID = ID()
    let title: String
    let content: String
    let date: Date = .init()
}

struct ContentView: View {
    
    // Date에 따라서 Section을 분리할 수 있음
    @State var memos: [Memo] = [
        Memo(title: "안녕", content: ""),
        Memo(title: "Hello", content: ""),
        Memo(title: "Bonjur", content: ""),
        Memo(title: "사와디캅", content: ""),
        Memo(title: "곤니찌와", content: ""),
    ]
    
    var body: some View {
        NavigationStack {
            List(memos) {
                Text($0.title)
                    .font(.system(size: 20))
            }
            .navigationTitle("Memo")
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    Button {
                        memos.append(.init(title: "새로운 아이템", content: ""))
                    } label: {
                        Image(systemName: "plus")
                    }

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
