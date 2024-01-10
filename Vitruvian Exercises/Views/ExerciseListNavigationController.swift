import UIKit
import SwiftUI

struct ExerciseList: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ExerciseListNavigationController {
        return ExerciseListNavigationController(viewModel: ExerciseViewModel())
    }

    func updateUIViewController(_ uiViewController: ExerciseListNavigationController, context: Context) {}
}

class ExerciseListNavigationController: UINavigationController {

    private let viewModel: ExerciseViewModel

    init(viewModel: ExerciseViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.prefersLargeTitles = true

        self.pushViewController(
            ExerciseListViewController(viewModel: viewModel),
            animated: true
        )
    }
}
