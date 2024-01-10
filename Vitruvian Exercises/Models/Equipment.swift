import Foundation

public enum Equipment: String, Codable, CaseIterable, CustomStringConvertible {
    case bar = "BAR",
         straps = "STRAPS",
         handles = "HANDLES",
         belt = "BELT",
         bench = "BENCH",
         rope = "ROPE",
         blackCables = "BLACK_CABLES",
         greyCables = "GREY_CABLES",
         shortBar = "SHORT_BAR",
         unknown
    
    public var description: String {
        switch self {
        case .bar: return "bar"
        case .straps: return "straps"
        case .handles: return "handles"
        case .belt: return "belt"
        case .bench: return "bench"
        case .rope: return "rope"
        case .blackCables: return "black cables"
        case .greyCables: return "grey cables"
        default: return ""
        }
    }
}
