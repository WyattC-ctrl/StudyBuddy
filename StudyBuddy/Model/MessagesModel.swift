//
//  MessagesModel.swift
//  StudyBuddy
//
//  Created by black dune house loaner on 12/3/25.
//

import SwiftUI
import Combine

let dummyUsers = [
    DummyUser(name: "Alice Chen", major: "CS 2027", avatar: "avatar1"),
    DummyUser(name: "Brian Lee", major: "ECE 2026", avatar: "avatar2"),
    DummyUser(name: "Carla Kim", major: "Info Sci 2025", avatar: "avatar3")
]

class MessagesModel: ObservableObject {
    @Published var matches: [DummyUser] = []
    
}
