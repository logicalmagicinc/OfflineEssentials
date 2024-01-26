//
//  File.swift
//  
//
//  Created by Justin Allen on 1/26/24.
//

import Foundation
import SwiftUI

public struct SecureInputView: View {
    
    @Binding private var text: String
    @State private var isSecured: Bool = true
    private var title: String
    
    public init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    public var body: some View {
        ZStack(alignment: .trailing) {
            // TODO: fix this, also hide the toggle when the string is empty.
            Group {
                if isSecured {
                    SecureField(title, text: $text)
                } else {
                    TextField(title, text: $text)
                }
            }.padding(.trailing, 32)

            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(.gray)
            }

        }
    }
}
