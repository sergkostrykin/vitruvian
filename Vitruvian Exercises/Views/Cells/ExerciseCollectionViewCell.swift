//
//  ExerciseCollectionViewCell.swift
//  Vitruvian Exercises
//
//  Created by Sergiy Kostrykin on 10/01/2024.
//

import UIKit
import Kingfisher

class ExerciseCollectionViewCell: UICollectionViewCell {
    
    static let identifier = ExerciseCollectionViewCell.description()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
        return imageView
    }()

    private lazy var infoContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.textColor = .gray
        return label
    }()

    private lazy var disclosureView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .lightGray
        return imageView
    }()

    private lazy var lineView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(exercise: Exercise) {
        titleLabel.text = exercise.name
        imageView.kf.setImage(with: exercise.videos?.first?.thumbnail)
        descriptionLabel.attributedText = createDescriptionAttributedString(for: exercise.summary)
    }
}

private extension ExerciseCollectionViewCell {
    
    func createUI() {
        backgroundColor = .white
        addSubview(imageView)
        addSubview(infoContainerView)
        infoContainerView.addSubview(titleLabel)
        infoContainerView.addSubview(descriptionLabel)
        addSubview(disclosureView)
        addSubview(lineView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            imageView.widthAnchor.constraint(equalToConstant: 70),
            imageView.heightAnchor.constraint(equalToConstant: 95)
        ])

        NSLayoutConstraint.activate([
            disclosureView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            disclosureView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            infoContainerView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            infoContainerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            infoContainerView.trailingAnchor.constraint(lessThanOrEqualTo: disclosureView.leadingAnchor, constant: 5)
        ])

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: infoContainerView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: infoContainerView.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: infoContainerView.trailingAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: infoContainerView.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: infoContainerView.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: infoContainerView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            lineView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            lineView.heightAnchor.constraint(equalToConstant: 0.7)
        ])
    }
    
    func createDescriptionAttributedString(for summary: ExerciseSummary?) -> NSAttributedString? {
        
        guard let summary = summary else { return nil }
        
        let attributedString = NSMutableAttributedString()
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14),
                                                         .foregroundColor: UIColor.gray]
        
        if !summary.equipment.isEmpty {
            let equipmentTextAttachment = NSTextAttachment()
            equipmentTextAttachment.image = UIImage(systemName: "dumbbell")?.withRenderingMode(.alwaysTemplate)
            attributedString.append(NSAttributedString(attachment: equipmentTextAttachment))
            attributedString.append(NSAttributedString(string: " ", attributes: attributes))
            
            let equipmentString = Array(summary.equipment).compactMap({ $0.description }).joined(separator: ", ")
            attributedString.append(NSAttributedString(string: equipmentString, attributes: attributes))
            
            attributedString.append(NSAttributedString(string: " ·", attributes: attributes))
        }
        
        if !summary.muscles.isEmpty {
            let musclesTextAttachment = NSTextAttachment()
            musclesTextAttachment.image = UIImage(systemName: "figure.mixed.cardio")?.withRenderingMode(.alwaysTemplate)
            attributedString.append(NSAttributedString(attachment: musclesTextAttachment))
            attributedString.append(NSAttributedString(string: " ", attributes: attributes))
            
            let musclesString = Array(summary.muscles).compactMap({ $0.description }).joined(separator: ", ")
            attributedString.append(NSAttributedString(string: musclesString, attributes: attributes))
        }
        return attributedString
    }
    
}
