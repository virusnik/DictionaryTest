//
//  SearchViewController.swift
//  DictionaryTest
//
//  Created by Sergio Veliz on 12.02.2023.
//

import UIKit
import Combine

class SearchViewController: UIViewController {
    
    //MARK: Subviews
    
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.isActive = true
        return searchController
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    //MARK: Other Properties
    private var viewModel: SearchViewModel = SearchViewModel(service: WordsSearchService())
    private var bindings = Set<AnyCancellable>()
    
    //MARK:  Life cycle
    init(viewModel: SearchViewModel)  {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        setupNavigationController(title: "Search words")
        setupSearchController(placeholder: "Search new words")
        setupTableView()
        setupConstraints()
    }
    
    //MARK: Initial setup
    private func setupTableView() {
        tableView.register(MeaningCell.self, forCellReuseIdentifier: MeaningCell.cellID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupSearchController(placeholder: String) {
        searchController.searchResultsUpdater = self
        searchController.definesPresentationContext = true
        searchController.searchBar.placeholder = placeholder
        
    }
    
    private func setupNavigationController(title: String) {
        navigationItem.searchController = searchController
        navigationItem.title = title
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    //MARK: Constraints
    private func setupConstraints() {
        view.addSubviewsForAutolayout([
            tableView,
            activityIndicator
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    
    func bindViewModelToView() {
        viewModel.$words
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .store(in: &bindings)
        
        let stateValueHandler: (ListViewModelState) -> Void = { [weak self] state in
            switch state {
            case .loading:
                self?.activityIndicator.startAnimating()
            case .finishedLoading:
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
            case .error(let error):
                self?.showError(error)
                self?.activityIndicator.stopAnimating()
            }
        }
        
        viewModel.$state
            .receive(on: RunLoop.main)
            .sink(receiveValue: stateValueHandler)
            .store(in: &bindings)
    }
    
    private func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}


//MARK: UISearchResultsUpdating delegate

extension SearchViewController: UISearchResultsUpdating  {
    
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchBar.searchTextField.textPublisher
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak viewModel] in
                viewModel!.getWord(searchText: $0.withoutPunctuations)
            }
            .store(in: &bindings)
        bindViewModelToView()
    }
}

//MARK: UITableViewDataSource
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getSectionsCount()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getRowsCount(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MeaningCell.cellID) as? MeaningCell else { return UITableViewCell() }
        let meaning = viewModel.words[indexPath.section].meanings[indexPath.row]
        cell.configure(with: meaning)
        return cell
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}

