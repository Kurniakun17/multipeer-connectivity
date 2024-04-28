//
//  UserCharacter.swift
//  Multipeer
//
//  Created by Kurnia Kharisma Agung Samiadjie on 27/04/24.
//

import SwiftUI

struct UserCharacter: View {
    var imgName: String
    var isNavigating: Bool = false
    @State var isAnimating = false
    @Binding var selectedChar: String
    @Binding var isSheetOpen: Bool
    @State var isActive: Bool = false

    var body: some View {
        Button(action: {
            isAnimating.toggle()
            selectedChar = imgName
            isSheetOpen.toggle()
            if isNavigating {
                isActive = true
            }
        }) {
            Image(imgName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(x: isAnimating ? 0.9 : 1, y: isAnimating ? 0.9 : 1, anchor: .center)
        }
    }
}
