//
//  FavoriteTableViewCell.swift
//  Unsplash
//
//  Created by Шамиль Моллачиев on 06.10.2022.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    let photoImageView: UIImageView = {
        let photoImageView = UIImageView()
        photoImageView.clipsToBounds = true
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        return photoImageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.layer.cornerRadius = photoImageView.frame.width / 2
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.addSubview(photoImageView)
        self.addSubview(nameLabel)
    }
}

// MARK: - Constraints
extension FavoriteTableViewCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            photoImageView.heightAnchor.constraint(equalToConstant: 60),
            photoImageView.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
}
