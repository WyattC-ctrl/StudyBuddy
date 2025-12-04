//
//  Messages.swift
//  StudyBuddy
//
//  Created by black dune house loaner on 12/1/25.
//

import SwiftUI

struct MessagesPage: View {
    @EnvironmentObject var messages: MessagesModel

    var body: some View {
        VStack {
            Image("StudyBuddyLogoRed")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)

            Text("New Matches")
                .bold()
                .padding(.top, 8)

            List(messages.matches) { user in
                HStack(spacing: 16) {
                    Image(.pfp) // Assuming pfp is String name of image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())

                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)
                        Text("Most recent message here")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                }
                .padding(.vertical, 8)
            }
            .listStyle(PlainListStyle())
            .frame(maxHeight: 300) // Limit height, so other UI fits

            Text("Messages")
                .bold()
                .padding(.top, 32)

            ScrollView {
                ForEach(messages.conversations) { convo in
                    HStack(spacing: 16) {
                        Image(convo.user.pfp)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())

                        VStack(alignment: .leading) {
                            Text(convo.user.name)
                                .font(.headline)
                            Text(convo.lastMessage)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 38)
                }
            }

            Spacer()

            // Bottom navigation bar
            HStack(spacing: 40) {
                NavigationLink(destination: StudyBuddyPage()) {
                    Image("StudyBuddyLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }

                NavigationLink(destination: CalendarPage()) {
                    Image(systemName: "calendar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }

                NavigationLink(destination: ExplorePage()) {
                    Image(systemName: "hand.raised.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }

                // Disable navigation link for current tab
                Image(systemName: "message.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)

                NavigationLink(destination: ProfilePage()) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(Color(hex: 0x9E122C))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal)
            .padding(.bottom, 10)
        }
        .padding(.top, 100)
    }
}

#Preview {
    MessagesPage()
        .environmentObject(MessagesModel()) // provide dummy or real instance
}
