//
//  DummyUser.swift
//  StudyBuddy
//
//  Created by black dune house loaner on 12/3/25.
//

import SwiftUI
import Combine


struct DummyUser: Identifiable, Equatable {
    let id: UUID = UUID()
    var name: String
    let major: String
    let avatar: String
//    var email: String
}
