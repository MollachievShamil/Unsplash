//
//  FavouriteImagesViewController.swift
//  Unsplash
//
//  Created by Шамиль Моллачиев on 06.10.2022.
//

import UIKit

class FavouriteImagesViewController: UIViewController {
    
    var presenter: FavoriteImagesPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    // MARK: - Delegates
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: -  PresenterProtocol
extension FavouriteImagesViewController: FavoriteImagesViewProtocol {
    func sucsess() {
        tableView.reloadData()
    }
}

// MARK: - TableViewDeleagte & DataSource

extension FavouriteImagesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNumresOfCells() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteTableViewCell
        cell.nameLabel.text = presenter?.fetchName(index: indexPath.row)
        cell.photoImageView.image = presenter?.makeImage(ind: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.goToDetailsModule(ind: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter?.deleteWithSwipe(ind: indexPath.row)
        }
    }
}

// MARK: - Constraints.
extension FavouriteImagesViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
