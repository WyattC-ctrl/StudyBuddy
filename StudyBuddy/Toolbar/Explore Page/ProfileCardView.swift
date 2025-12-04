//
//  ProfileCardView.swift
//  StudyBuddy
//
//  Created by black dune house loaner on 12/3/25.
//

import SwiftUI

struct ProfileCardView: View {
    let user: DummyUser
    @EnvironmentObject var profile: Profile

    // Brand colors
    private let brandRed = Color(hex: 0x9E122C)
    private let fieldBorder = Color(.systemGray3)
    private let placeholderCircle = Color(.systemGray4)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {

                // MARK: – Logo Row
                HStack {
                    Image("StuddyBuddyLogoRed")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                    Spacer()
                }
                .padding(.top, 4)

                // MARK: – Header Info
                HStack(alignment: .top, spacing: 16) {
                    avatar

                    VStack(alignment: .leading, spacing: 6) {
                        Text("@testing_123")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                        Text(user.name)
                            .font(.title2.weight(.semibold))
                            .foregroundStyle(.primary)

                        VStack(alignment: .leading, spacing: 2) {
                            infoRow("Major:", user.major)
                            infoRow("Minors:", "Info Sci, Game Design")
                            infoRow("College:", "Engineering")
                        }
                    }

                    Spacer()
                }

                // MARK: – Preferred Times Card
                preferredTimesCard

                // MARK: – Courses Section
                coursesSection

                // MARK: – Favorite Study Locations
                favoriteLocationsSection
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            .padding(.top, 12)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 3)
    }

    // MARK: – Avatar
    private var avatar: some View {
        ZStack {
            if let img = UIImage(named: user.avatar) {
                Image(uiImage: img)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 90, height: 90)
                    .clipShape(Circle())
            } else {
                Circle()
                    .fill(placeholderCircle)
                    .frame(width: 90, height: 90)
            }
        }
    }

    // MARK: – Info Row (Major/Minor/College)
    private func infoRow(_ label: String, _ value: String) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 6) {
            Text(label)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.primary)

            Text(value)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    // MARK: – Preferred Times Card
    private var preferredTimesCard: some View {
        HStack(alignment: .top, spacing: 16) {

            // Left: time icons (day + morning)
            HStack(spacing: 22) {
                timeIcon("sunrise.fill")
                timeIcon("sun.max.fill")
            }

            Spacer(minLength: 12)

            VStack(alignment: .leading, spacing: 4) {
                Text("Preferred time(s):")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text("9am - 11am")
                    .font(.subheadline.weight(.semibold))
                Text("4pm - 7pm")
                    .font(.subheadline.weight(.semibold))
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.label).opacity(0.35), lineWidth: 1)
        )
    }

    private func timeIcon(_ system: String) -> some View {
        ZStack {
            Circle()
                .fill(Color(.systemGray4))
                .frame(width: 52, height: 52)
            Image(systemName: system)
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(brandRed)
        }
    }

    // MARK: – Courses Section
    private var coursesSection: some View {
        VStack(alignment: .leading, spacing: 10) {

            Text("Courses")
                .font(.headline)
                .foregroundStyle(.primary)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(["CS 3110", "MATH 2930", "INFO 1998", "CS 2800", "CHIN 1109", "BIO 1010"], id: \.self) { course in
                        Text(course.uppercased())
                            .font(.subheadline.weight(.bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(brandRed)
                            )
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
            }
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(fieldBorder, lineWidth: 1)
            )
        }
    }


    // MARK: – Favorite Locations Row
    private var favoriteLocationsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Favorite study locations!")
                .font(.headline)

            HStack(spacing: 40) {
                locationTile("Library", systemImage: "books.vertical")
                locationTile("Cafe", systemImage: "cup.and.saucer")
                locationTile("Study Hall", systemImage: "building.columns")
            }
        }
    }

    private func locationTile(_ title: String, systemImage: String) -> some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color(.label).opacity(0.6), lineWidth: 1.5)
                    .frame(width: 64, height: 64)

                Image(systemName: systemImage)
                    .font(.system(size: 24))
                    .foregroundStyle(brandRed)
            }

            Text(title)
                .font(.footnote)
                .foregroundStyle(.primary)
        }
    }
}

#Preview {
    ProfileCardView(
        user: DummyUser(name: "Testing", major: "Computer Science 28’", avatar: "avatar1")
    )
    .environmentObject(Profile())
}
