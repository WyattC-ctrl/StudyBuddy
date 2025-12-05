//
//  MatchPopup.swift
//  StudyBuddy
//
//  Created by black dune house loaner on 12/3/25.
//

import SwiftUI

struct MatchPopup: View {
    let user: DummyUser
    @Binding var visible: Bool

    var body: some View {
        if visible {
            ZStack {
                Color.black.opacity(0.55)
                    .ignoresSafeArea()

                VStack(spacing: 22) {
                    Text("It’s a Match!")
                        .font(.largeTitle.bold())
                        .foregroundColor(.black)
                    Image(user.avatar)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .shadow(radius: 6)
                    Text(user.name)
                        .font(.title.bold())
                        .foregroundColor(.black)
                    Button("Go to Messages") {
                        visible = false
                        // Navigate to messages
                    }
                    .font(.headline)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 10)
                    .background(Color(hex: 0x9E122C))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.vertical, 35)
                .padding(.horizontal, 40)
                .background(Color.white)                        
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(color: .black.opacity(0.25), radius: 20)
                .transition(.scale)
            }
            .animation(.easeOut, value: visible)
        }
    }
}
