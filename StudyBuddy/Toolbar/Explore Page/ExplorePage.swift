//
//  Explore.swift
//  StudyBuddy
//
//  Created by black dune house loaner on 12/1/25.
//

import SwiftUI

struct ExplorePage: View {
    @EnvironmentObject var messages: MessagesModel
    @EnvironmentObject var profile: Profile

    @State private var users = dummyUsers
    @State private var index = 0

    @State private var offset: CGSize = .zero
    @State private var showMatchPopup = false

    var body: some View {
        ZStack {
            
// MARK: - Swipe Container
            SwipeCardContainer(
                offset: $offset,
                isMatched: $showMatchPopup,
                onSwipeLeft: handleReject,
                onSwipeRight: handleMatch
            ) {
                ProfileCardView(
                    user: users[index]
                )
                .environmentObject(profile)
            }

            MatchPopup(
                user: users[index],
                visible: $showMatchPopup
            )
        }
        .navigationBarTitle("Explore")
        .navigationBarTitleDisplayMode(.inline)
    }

// MARK: - Swipe Logic
    private func handleMatch() {
        let matchedUser = users[index]
        messages.matches.append(matchedUser)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            loadNext()
        }
    }

    private func handleReject() {
        loadNext()
    }

    private func loadNext() {
        index = (index + 1) % users.count
        offset = .zero
    }
}
#Preview {
    ExplorePage()
        .environmentObject(MessagesModel())
        .environmentObject(Profile())
}
