StudyBuddy
StudyBuddy is an iOS application built with SwiftUI designed to connect students through a profile-based matching system. Whether you're looking for a tutor, a study group, or a partner for a specific project, StudyBuddy streamlines the process of finding the right academic peer.

Features
Profile Swiping: Intuitive "Swipe Through Profiles" interface to find academic matches quickly.

Session Management: Robust authentication handling via a SessionStore to maintain user state and profile data.

Real-time Messaging: Integrated messaging model to facilitate communication once a match is made.

Custom Design System: Supports Figma-to-SwiftUI workflow with a custom Hex color extension for high-fidelity UI implementation.

Technical Stack
Framework: SwiftUI

State Management: @EnvironmentObject and @StateObject for global session and message handling.

Architecture: Clean, modular Swift code focused on reactivity and real-time updates.

Project Structure
StudyBuddyApp.swift: The main entry point that initializes the SessionStore and MessagesModel.

ContentView.swift: The primary view controller that toggles between authentication states and the main discovery feed.

Color.swift: Utility extension for initializing Color objects using Hex codes (e.g., 0x1E1E1E).

Setup Instructions
Clone the repository:

Bash
git clone https://github.com/WyattC-ctrl/StudyBuddy.git
Open in Xcode: Navigate to the project folder and open StudyBuddy.xcodeproj.

Build and Run: Select a simulator (e.g., iPhone 15) and press Cmd + R.

Contributing
This project was developed as a tool to enhance collaborative learning. If you have ideas for new features—like calendar integration or subject-based filtering—feel free to fork the repo and submit a pull request!
