//
//  MainViewController.swift
//  Unsplash
//
//  Created by Шамиль Моллачиев on 06.10.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    var presenter: MainPresenterProtocol!
    var timer: Timer?
    var semaphore = true
    var searchingText = ""
    var pageCounter = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setConstraints()
        setupSearchController()
    }
    
    let indicatorActivity : UIActivityIndicatorView = {
        let indicatorActivity = UIActivityIndicatorView()
        indicatorActivity.style = .medium
        indicatorActivity.color = .black
        indicatorActivity.translatesAutoresizingMaskIntoConstraints = false
        indicatorActivity.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        indicatorActivity.isUserInteractionEnabled = false
        return indicatorActivity
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MainViewControllerCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    func createCustomButton(selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: selector, for: .touchUpInside)
        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private func setupSearchController() {
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    @objc
    func refreshButtonTapped() {
        if semaphore {
            lockUI()
            presenter.fetchPhotoModels()
        }
    }
    
    // MARK: - Paginator
    func lockUI() {
        semaphore = false
        indicatorActivity.startAnimating()
        navigationItem.rightBarButtonItem = nil
        searchController.searchBar.isHidden = true
    }
    
    func unlockUI() {
        semaphore = true
        indicatorActivity.stopAnimating()
        indicatorActivity.hidesWhenStopped = true
        navigationItem.rightBarButtonItem = createCustomButton(selector: #selector(refreshButtonTapped))
        searchController.searchBar.isHidden = false
    }
    
    // MARK: - Delegates
    func setDelegate() {
        collectionView.dataSource = self
        collectionView.delegate = self
        searchController.searchBar.delegate = self
    }
}

// MARK: - Presenter Delegate
extension MainViewController: MainViewProtocol {
    func sucsess() {
        collectionView.reloadData()
        unlockUI()
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
}

// MARK: - Collection View Delegates
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.photoModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MainViewControllerCell
        cell.imageView.image = presenter.makeImage(img: presenter.photoModels[indexPath.row].picture)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = presenter.photoModels[indexPath.row]
        presenter.goToDetailsModule(model: model)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(
            width: (view.frame.size.width / 2) - 12,
            height: (view.frame.size.width / 2) - 12
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
    }
}

// MARK: - Search Bar Delegate
extension MainViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        presenter.fetchSearchingPhotoModels(name: searchBar.text ?? "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchingText = ""
    }
}

// MARK: - InfinityScroll

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (collectionView.contentSize.height - scrollView.frame.size.height - 100) {
            guard semaphore else { return }
            lockUI()
            if searchingText != "" {
                pageCounter += 1
                presenter.addMorePhotoForInfinityScrollWithSearching(name: searchingText, page: pageCounter)
            } else {
                presenter.addMorePhotoForInfinityScroll()
            }
        }
    }
}

// MARK: - Constraints
extension MainViewController {
    func setConstraints() {
        
        view.addSubview(collectionView)
        collectionView.addSubview(indicatorActivity)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            indicatorActivity.topAnchor.constraint(equalTo: view.topAnchor),
            indicatorActivity.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            indicatorActivity.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            indicatorActivity.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
