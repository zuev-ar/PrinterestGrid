//
//  ContentView.swift
//  PrinterestGrid
//
//  Created by Arkasha Zuev on 21.11.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var numberOfColumns: Int = 2
    var gridItems = [GridItem]()
    
    init() {
        for i in 1 ..< 51 {
            let randomHeight = CGFloat.random(in: 100 ... 300)
            gridItems.append(GridItem(height: randomHeight, imgString: String(i)))
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    PrinterestGrid(gridItems: gridItems, numberOfColumns: numberOfColumns, spacing: 20, horizontalPadding: 20)
                }
                .toolbar(content: {
                    ToolbarItemGroup(placement: .bottomBar) {
                        removeButton
                        addButton
                    }
                })
            }
            .navigationTitle("Pinterest Grid")
        }
    }
    
    var removeButton: some View {
        Button {
            numberOfColumns -= 1
        } label: {
            Image(systemName: "minus.circle")
        }
        .disabled(numberOfColumns == 1)
        .foregroundColor(.black)
    }
    
    var addButton: some View {
        Button {
            numberOfColumns += 1
        } label: {
            Image(systemName: "plus.circle")
        }
        .foregroundColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
