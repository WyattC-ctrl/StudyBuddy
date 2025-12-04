//
//  ProfileModel.swift
//  StudyBuddy
//
//  Created by You on 12/3/25.
//

import SwiftUI
import Combine

final class Profile: ObservableObject {
    enum StudyTime: String, CaseIterable, Identifiable, Codable, Hashable {
        case morning, day, night
        var id: String { rawValue }
        
        var label: String {
            switch self {
            case .morning: return "Morning"
            case .day:     return "Day"
            case .night:   return "Night"
            }
        }
        
        var systemImage: String {
            switch self {
            case .morning: return "sunrise.fill"
            case .day:     return "sun.max.fill"
            case .night:   return "moon.stars.fill"
            }
        }
    }
    
    enum Location: String, CaseIterable, Identifiable, Codable, Hashable {
        case library
        case cafe
        case studyHall
        
        var id: String { rawValue }
        
        var title: String {
            switch self {
            case .library:   return "Library"
            case .cafe:      return "Cafe"
            case .studyHall: return "Study Hall"
            }
        }
        
        var systemImage: String {
            switch self {
            case .library:   return "books.vertical"
            case .cafe:      return "cup.and.saucer"
            case .studyHall: return "building.columns"
            }
        }
    }
    
    // Legacy single fields (kept for compatibility if you still use them somewhere)
    @Published var name: String = ""
    @Published var major: String = "" // optional: can set to majors.first if you want a "primary" major
    @Published var favoriteArea: String = ""
    
    // New multi-value fields
    @Published var majors: [String] = []
    @Published var minors: [String] = []
    
    // College (single)
    @Published var college: String = ""
    
    // Courses and preferences
    @Published var courses: [String] = []
    @Published var selectedTimes: Set<StudyTime> = []
    @Published var selectedLocations: Set<Location> = []
    
    // Photo
    @Published var photoData: Data? = nil
    
    // Convenience
    var hasPhoto: Bool { photoData != nil }
    var uiImage: UIImage? {
        guard let data = photoData else { return nil }
        return UIImage(data: data)
    }
}

