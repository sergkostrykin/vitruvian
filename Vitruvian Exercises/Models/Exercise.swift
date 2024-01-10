import Foundation

public struct ExerciseSummary: Codable, Equatable {
    public var equipment: Set<Equipment>
    public var muscles: Set<MuscleGroup>
    
    public init(equipment: Set<Equipment> = [], muscles: Set<MuscleGroup> = []) {
        self.equipment = equipment
        self.muscles = muscles
    }
}

public struct Exercise: Codable, Identifiable, Hashable {
    public init(
        id: String? = nil,
        name: String? = nil,
        description: String? = nil,
        videos: [ExerciseVideo]? = nil,
        summary: ExerciseSummary? = nil
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.videos = videos
        self.summary = summary
    }

    public static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.description == rhs.description &&
        lhs.videos == rhs.videos &&
        lhs.summary == rhs.summary
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }

    public var id: String?

    public var name: String?
    public var description: String?
    public var videos: [ExerciseVideo]?

    public var summary: ExerciseSummary?
}
