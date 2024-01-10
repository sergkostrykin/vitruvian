import Foundation

public enum ExerciseVideoAngle: String, Codable, CaseIterable {
    case front = "FRONT", isometric = "ISOMETRIC", side = "SIDE"
}

public struct ExerciseVideo: Codable, Identifiable, Equatable {
    public init(id: String, video: URL, thumbnail: URL, angle: ExerciseVideoAngle) {
        self.id = id
        self.video = video
        self.thumbnail = thumbnail
        self.angle = angle
    }

    public var id: String
    public var video: URL
    public var thumbnail: URL
    public var angle: ExerciseVideoAngle
}
