//
//  EmptySquare.swift
//  Post
//
//  Created by Justin Allen on 7/25/23.
//

import SwiftUI

struct EmptySquare: View {
    @State var height: CGFloat = 10
    var body: some View {
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

struct EmptySquare_Previews: PreviewProvider {
    static var previews: some View {
        EmptySquare()
    }
}
