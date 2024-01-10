//
//  ExerciseDetailViewModel.swift
//  Vitruvian Exercises
//
//  Created by Sergiy Kostrykin on 10/01/2024.
//

import Foundation
import AVFoundation

class ExerciseDetailViewModel: NSObject, ObservableObject {

    @Published var isDescriptionExpanded: Bool = false
    
    let exercise: Exercise
    
    var player: AVPlayer?
    
    
    var isEquipmentSectionEnabled: Bool {
        guard let summary = exercise.summary else { return false }
        return !summary.equipment.isEmpty
    }
    
    var equipmentSectionTitle: String {
        "Equipment"
    }

    var equipmentSectionContent: String {
        guard let equipment = exercise.summary?.equipment else { return "" }
        return Array(equipment).compactMap({ $0.description }).joined(separator: ", ")
    }

    
    var isMusclesSectionEnabled: Bool {
        guard let summary = exercise.summary else { return false }
        return !summary.muscles.isEmpty
    }
    
    var musclesSectionTitle: String {
        "Muscles"
    }

    var musclesSectionContent: String {
        guard let muscles = exercise.summary?.muscles else { return "" }
        return Array(muscles).compactMap({ $0.description }).joined(separator: ", ")
    }

    
    var isDesciptionSectionEnabled: Bool {
        !(exercise.description ?? "").isEmpty
    }
    
    var descriptionSectionTitle: String {
        "Description"
    }
    
    var descriptionSectionContent: String {
        exercise.description ?? ""
    }
    
    var expandButtonName: String {
        isDescriptionExpanded ? "chevron.up" : "chevron.down"
    }

    init(exercise: Exercise) {
        self.exercise = exercise
        if let url = exercise.videos?.first?.video {
            self.player = AVPlayer(url: url)
        }
    }
}
