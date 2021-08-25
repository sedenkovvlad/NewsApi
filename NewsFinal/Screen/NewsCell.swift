//
//  NewsCell.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 24.08.2021.
//

import UIKit

class NewsCell: UITableViewCell {
    
    var imageNews = UIImageView()
    var borderLine = UIView()
    var titleLabel = UILabel()
    var dateLabel = UILabel()
    
    static var identifier = "cell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(imageNews)
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(borderLine)
        
        configureImageNews()
        configureTitleLabel()
        configureDateLabel()
        configureBorderLine()
        
        dateLabelConstraints()
        borderLineConstraints()
        imageViewConstraints()
        titleLableConstraints()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    //MARK: - Configure
    func configureImageNews(){
        imageNews.layer.cornerRadius = 10
        imageNews.clipsToBounds = true
        
    }
    func configureTitleLabel(){
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
    }
    func configureDateLabel(){
        dateLabel.numberOfLines = 0
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.textAlignment = .center
    }
    
    func configureBorderLine(){
        borderLine.backgroundColor = .lightGray
    }
    
    //MARK: - Constraints
    
    func imageViewConstraints(){
        imageNews.translatesAutoresizingMaskIntoConstraints = false
        imageNews.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageNews.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -12).isActive = true
        imageNews.heightAnchor.constraint(equalToConstant: 120).isActive = true
        imageNews.widthAnchor.constraint(equalToConstant: 190).isActive = true
        
    }
    func titleLableConstraints(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: imageNews.leadingAnchor, constant: -20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: borderLine.bottomAnchor, constant: -15).isActive = true
    }
    func dateLabelConstraints(){
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
    }
    func borderLineConstraints(){
        borderLine.translatesAutoresizingMaskIntoConstraints = false
        borderLine.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: -30).isActive = true
        borderLine.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        borderLine.widthAnchor.constraint(equalToConstant: contentView.frame.width / 2).isActive = true
        borderLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageNews.image = nil
    }
}
