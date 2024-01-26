//
//  EmptySquare.swift
//  Post
//
//  Created by Justin Allen on 7/25/23.
//

import SwiftUI

public struct EmptySquare: View {
    @State var height: CGFloat = 10
    public var body: some View {
        GeometryReader { geometry in
            let sideLength = geometry.size.width
            Color.clear
                .cornerRadius(8)
                .frame(width: sideLength, height: sideLength)
                .onAppear {
                    height = sideLength
                }
        }.frame(height: height)
    }
}
