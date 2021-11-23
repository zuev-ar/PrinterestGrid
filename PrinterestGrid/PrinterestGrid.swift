//
//  PrinterestGrid.swift
//  PrinterestGrid
//
//  Created by Arkasha Zuev on 21.11.2021.
//

import SwiftUI

struct GridItem: Identifiable {
    let id = UUID()
    let height: CGFloat
    let imgString: String
}

struct PrinterestGrid: View {
    
    struct Column: Identifiable {
        let id = UUID()
        var gridItems = [GridItem]()
    }
    
    let spacing: CGFloat
    let horizontalPadding: CGFloat
    let columns: [Column]
    
    init(gridItems: [GridItem], numberOfColumns: Int, spacing: CGFloat = 20, horizontalPadding: CGFloat = 20) {
        self.spacing = spacing
        self.horizontalPadding = horizontalPadding
        
        var columns = [Column]()
        for _ in 0 ..< numberOfColumns {
            columns.append(Column())
        }
        
        var columnsHeight = Array<CGFloat>(repeating: 0, count: numberOfColumns)
        
        // распределяем элементы по колонкам
        for gridItem in gridItems {
            var smallestColumnIndex = 0
            var smallestHeight = columnsHeight.first!
            
            for i in 1 ..< columnsHeight.count {
                let currentHeight = columnsHeight[i]
                if currentHeight < smallestHeight {
                    smallestHeight = currentHeight
                    smallestColumnIndex = i
                }
            }
            
            columns[smallestColumnIndex].gridItems.append(gridItem)
            columnsHeight[smallestColumnIndex] += gridItem.height
        }
        
        self.columns = columns
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: spacing) {
            ForEach(columns) { column in
                LazyVStack(spacing: spacing) {
                    ForEach(column.gridItems) { gridItem in
                        getItemView(gridItem: gridItem)
                    }
                }
            }
        }
        .padding(.horizontal, horizontalPadding)
    }
    
    func getItemView(gridItem: GridItem) -> some View {
        ZStack {
            GeometryReader { reader in
                Image(systemName: gridItem.imgString + ".square")
                    .resizable()
                    .scaledToFit()
                    .frame(width: reader.size.width, height: reader.size.height, alignment: .center)
            }
        }
        .frame(height: gridItem.height)
        .frame(maxHeight: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 13))
    }
}

//struct PrinterestGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        PrinterestGrid()
//    }
//}
