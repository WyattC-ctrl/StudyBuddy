StudyBuddy
StudyBuddy is a mobile application built with SwiftUI designed to connect students through a profile-based matching system. The project utilizes a centralized session management system and a real-time messaging model to facilitate academic collaboration.

Features
Profile Discovery: Implements an interactive interface for browsing student profiles, optimized for academic networking.

Authentication State Management: Automated handling of user authentication status through a centralized SessionStore, ensuring secure access to user-specific data.

Real-time Messaging System: Integrated MessagesModel to facilitate seamless communication and coordination between matched study partners.

Figma-to-Code Integration: Custom Color extensions enable the direct use of hex codes (e.g., 0x1E1E1E), maintaining high-fidelity design consistency from Figma to SwiftUI.

Asynchronous Session Restoration: Utilizes Swift Task modifiers to automatically restore user sessions upon application launch for a frictionless user experience.

Technical Architecture
The application architecture relies on the following SwiftUI patterns:

SessionStore: Manages the global state of the user, including authentication and profile persistence.

MessagesModel: Handles the data logic and state for user-to-user communications.

EnvironmentObjects: Provides seamless access to session and messaging data across the entire view hierarchy.

Hex Color Support: A custom initializer for the Color struct to simplify styling from design mockups.

File Overview
StudyBuddyApp.swift: The main entry point that configures the app's global state and environment objects.

ContentView.swift: The root view that routes users to the appropriate interface based on their authentication status.

Color.swift: A utility extension enabling the use of hex codes for precise UI styling.

Installation
Clone the repository: git clone https://github.com/WyattC-ctrl/StudyBuddy.git

Open the project in Xcode: open StudyBuddy.xcodeproj

Build and run the application on an iOS Simulator or a physical device using Cmd + R.

Usage
Upon launch, the application attempts to restore any existing session asynchronously. Users can navigate the discovery feed to find study partners. The UI is optimized for a Figma-to-Code workflow, utilizing custom hex color definitions to ensure visual consistency across all views.

Would you like me to help you add a section for "Future Enhancements" to show recruiters what features you plan to build next?
