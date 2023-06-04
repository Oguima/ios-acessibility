//
//  View+Extensions.swift
//  HelloAccessibility
//
//  Created by rafael.guimaraes on 30/04/23.
//

import SwiftUI

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
extension View {
    func scaledFont(name: String, size: Double) -> some View {
        return self.modifier(ScaledFont(name: name, size: size))
    }
}
