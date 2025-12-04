import SwiftUI

struct EditProfilePage: View {
    @EnvironmentObject var profile: Profile
    private let brandYellow = Color(hex: 0xFBCB77)

    var body: some View {
        VStack(spacing: 16) {
            Text("Edit Profile")
                .font(.title2.weight(.semibold))
            Text("Build this screen later.")
                .foregroundStyle(.secondary)

            // Example of accessing profile data
            if let img = profile.uiImage {
                Image(uiImage: img)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
            } else {
                Circle()
                    .fill(Color(.systemGray4))
                    .frame(width: 120, height: 120)
            }
        }
        .padding()
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .background(brandYellow.opacity(0.0))
    }
}

#Preview {
    let p = Profile()
    return NavigationStack {
        EditProfilePage().environmentObject(p)
    }
}
