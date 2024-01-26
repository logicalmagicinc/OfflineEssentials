//
//  SquareImage.swift
//  Post
//
//  Created by Justin Allen on 7/25/23.
//

import SwiftUI

struct SquareImage: View {
    var image: UIImage
    @State private var height: CGFloat = 10
    
    var body: some View {
        GeometryReader { geometry in
            let sideLength = geometry.size.width
            
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .cornerRadius(8)
                .frame(width: sideLength, height: sideLength)
                .onAppear {
                    height = sideLength
                }
                    
        }
        .frame(height: height)
    }
}

//
//struct SquareImage_Previews: PreviewProvider {
//    static var previews: some View {
//        SquareImage()
//    }
//}
