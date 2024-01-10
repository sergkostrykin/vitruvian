import SwiftUI
import Combine

class ExerciseListViewController: UIViewController {

    enum Section {
        case main
    }
    
    let viewModel: ExerciseViewModel

    private var subscriptions = Set<AnyCancellable>()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Exercise>!
    
    private lazy var collectionView: UICollectionView = {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)        
        collectionView.register(ExerciseCollectionViewCell.self, forCellWithReuseIdentifier: ExerciseCollectionViewCell.identifier)
        collectionView.delegate = self
        return collectionView
    }()
    
    init(viewModel: ExerciseViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.title = NSLocalizedString("Exercises", comment: "")
        self.navigationItem.largeTitleDisplayMode = .always
        
        createUI()
        configureDataSource()
        fetchData()
        
        // TODO: - Implement a list of exercises here using UICollectionView.
        // Render the exercise name, thumbnail, a list of muscle groups, and equipment.
        //
        // In your implementation:
        // - Load data from the Combine view model to populate the list. Make sure
        //   to update the list when the data in the view model changes.
        //
        // - Use compositional layouts (with the list layout configuration) and
        //   diffable data sources, instead of flow layouts and UICollectionViewDataSources
        //
        // - Use regular UICollectionViewCells, not UIHostingConfiguration
        //
        // - Use programmatic Auto Layout (NSLayoutConstraint) to layout this
        //   view and its cells, rather than Interface Builder
        //
        // - Push the SwiftUI `ExerciseDetail` view for an exercise to the navigation
        //   stack when an exercise row is selected.
    }
}

private extension ExerciseListViewController {
    
    func createUI() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Exercise>(collectionView: collectionView) { (collectionView, indexPath, exercise) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExerciseCollectionViewCell.identifier, for: indexPath) as! ExerciseCollectionViewCell
            cell.setup(exercise: exercise)
            return cell
        }
    }
    
    func fetchData() {
        viewModel.$exercises
            .receive(on: DispatchQueue.main)
            .sink { [weak self] exercises in
                self?.updateSnapshot(with: exercises)
            }
            .store(in: &subscriptions)

        Task {
            await viewModel.fetchExercises()
        }
    }
    
    func updateSnapshot(with exercises: [Exercise]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Exercise>()
        snapshot.appendSections([.main])
        snapshot.appendItems(exercises, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func navigateToExerciseDetail(exercise: Exercise) {
        let detailView = ExerciseDetail(vm: .init(exercise: exercise))//(exercise: exercise)
        let hostingController = UIHostingController(rootView: detailView)
        self.navigationController?.pushViewController(hostingController, animated: true)
    }    
}

extension ExerciseListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let exercise = viewModel.exercises[indexPath.item]
        navigateToExerciseDetail(exercise: exercise)
    }
}
