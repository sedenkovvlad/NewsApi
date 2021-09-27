//
//  FavoriteCell.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 24.09.2021.
//

import UIKit
import Firebase

class FavoriteCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
        
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var sharedButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .orange
        return button
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .orange
        return button
    }()
    
    lazy var sharedButtonTapCallback: () -> ()  = { }
    lazy var deleteButtonTapCallback: () -> ()  = { }
    static let identifier = "cell"
    
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.addSubview(sharedButton)
        contentView.addSubview(deleteButton)
        contentView.addSubview(imageView)
        sharedButton.addTarget(self, action: #selector(sharedTapped), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        imageConstraints()
        titleLabelConstraints()
        sharedButtonConstraints()
        deleteButtonConstraits()
    }
    
    
    //MARK: - Constraints
    private func imageConstraints(){
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    private func titleLabelConstraints(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -60).isActive = true
    }
    private func sharedButtonConstraints(){
        sharedButton.translatesAutoresizingMaskIntoConstraints = false
        sharedButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        sharedButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
    }
    private func deleteButtonConstraits(){
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: sharedButton.leadingAnchor, constant: -5).isActive = true
    }
    

    //MARK: - Function
    static func createLayout() -> UICollectionViewCompositionalLayout{
        //Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1))
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        //Group
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.3)),
            subitem: item,
            count: 2
        )
        //Sections
        let section = NSCollectionLayoutSection(group: group)
        //Return
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func configureCell(newsFirebase: NewsFirebase){
        
        //title
        titleLabel.text = newsFirebase.title
        //image
        let ref = Storage.storage().reference(forURL: newsFirebase.newsURL)
        ref.getData(maxSize: Int64(1 * 1024 * 1024)) { [weak self] data, error in
            guard let imageData = data else {return}
            self?.imageView.image = UIImage(data: imageData)
        }
    }
    
    //MARK: - @objc
    @objc private func sharedTapped(){
        sharedButtonTapCallback()
    }
    
    @objc private func deleteTapped(){
        deleteButtonTapCallback()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
}
