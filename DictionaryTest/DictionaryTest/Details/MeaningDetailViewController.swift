//
//  MeaningDetailViewController.swift
//  DictionaryTest
//
//  Created by Sergio Veliz on 24.02.2023.
//

import UIKit
import Combine

class MeaningDetailViewController: UIViewController {
    
    //MARK: properties
    private var viewModel: MeaningDetailViewModel = MeaningDetailViewModel(service: WordsSearchService())
    private var bindings = Set<AnyCancellable>()
    
    //MARK: Subviews
    private let meaningImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage.init(systemName: "photo.fill")
        imageView.tintColor = .systemGroupedBackground
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var labelsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            wordLabel,
            translationLabel,
            transcriptionLabel
        ])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let wordLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    private let translationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.sizeToFit()
        return label
    }()
    
    private let transcriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    //MARK:  Life cycle
    init(viewModel: MeaningDetailViewModel)  {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationController()
        getData()
        setupConstraints()
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    //MARK: Constraints
    private func setupConstraints() {
        view.addSubviewsForAutolayout([
            meaningImageView,
            labelsStack,
        ])
        //meaning image view
        NSLayoutConstraint.activate([
            meaningImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 25),
            meaningImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            meaningImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            meaningImageView.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.4)
        ])
        NSLayoutConstraint.activate([
            labelsStack.leadingAnchor.constraint(equalTo: meaningImageView.leadingAnchor),
            labelsStack.trailingAnchor.constraint(equalTo: meaningImageView.trailingAnchor),
            labelsStack.topAnchor.constraint(equalTo: meaningImageView.bottomAnchor,constant: 16),
            labelsStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -16),
        ])
        
    }
    
    func getData() {
        let stateValueHandler: (ListViewModelState) -> Void = { [weak self] state in
            switch state {
            case .loading:
                print("LOADING")
            case .finishedLoading:
                if let item = self?.viewModel.meaning.first {
                    self?.fillContent(meaning: item)
                }
            case .error(let error):
                print("ERROR", error)
            }
        }
        
        viewModel.$state
            .receive(on: RunLoop.main)
            .sink(receiveValue: stateValueHandler)
            .store(in: &bindings)
    }
    
    func fillContent(meaning: MeaningDetail) {
        navigationItem.title = meaning.text ?? "Word"
        wordLabel.text = meaning.text
        translationLabel.text = meaning.translation.text
        transcriptionLabel.text = meaning.transcription
        viewModel.getImage(completion: { image in
            self.meaningImageView.image = image
        })
    }
}
