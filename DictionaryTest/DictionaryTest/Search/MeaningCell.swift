//
//  MeaningCell.swift
//  DictionaryTest
//
//  Created by Sergio Veliz on 14.02.2023.
//

import UIKit
import Combine

class MeaningCell: UITableViewCell {
    
    //MARK: Subviews
    
    private let previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = Style.Image.placeHolderPhoto
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.tintColor = .tertiarySystemBackground
        return imageView
    }()
    
    private lazy var labelsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [translationLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        return stack
    }()
    
    let translationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    //MARK: Other Properties
    private var cancellable: AnyCancellable?
    
    //MARK: Constraints
    private func setupConstraints() {
        
        addSubviewsForAutolayout([
            previewImageView,
            labelsStack
        ])
        
        NSLayoutConstraint.activate([
            previewImageView.topAnchor.constraint(equalTo: topAnchor,constant: 8),
            previewImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            previewImageView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -8),
            previewImageView.widthAnchor.constraint(equalTo: widthAnchor,multiplier: 0.2)
        ])
        
        NSLayoutConstraint.activate([
            labelsStack.topAnchor.constraint(equalTo: topAnchor,constant: 8),
            labelsStack.leadingAnchor.constraint(equalTo: previewImageView.trailingAnchor,constant: 8),
            labelsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            labelsStack.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -8),
            
        ])
    }
    
    //MARK: Life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        previewImageView.image = nil
        previewImageView.alpha = 0.0
        cancellable?.cancel()
    }
    
    func configure(with item: Meaning) {
        translationLabel.text = item.translation.text
        cancellable = loadImage(for: item).sink { [unowned self] image in self.showImage(image: image) }
    }
    
    private func loadImage(for item: Meaning) -> AnyPublisher<UIImage?, Never> {
        return Just(item.previewURL)
            .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
                let url = URL(string: "https:" + item.previewURL)!
                return ImageLoader.shared.loadImage(from: url)
            })
            .eraseToAnyPublisher()
    }
    
    private func showImage(image: UIImage?) {
        previewImageView.alpha = 0.0
        previewImageView.image = image
        self.previewImageView.alpha = 1.0
    }
    
}
