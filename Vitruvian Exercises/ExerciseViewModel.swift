import Foundation
import Combine

class ExerciseViewModel: ObservableObject {
    @Published private(set) var exercises: [Exercise] = []

    private let api = API()
    
    
    func fetchExercises() async {
        
        do {
            self.exercises = try await api.fetchExercises()
        } catch {
            
        }
    }

    // TODO: Fetch a list of exercises from the API endpoint
}
