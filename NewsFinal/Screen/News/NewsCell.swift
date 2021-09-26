//
//  NewsCell.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 24.08.2021.
//

import UIKit

class NewsCell: UITableViewCell {
    
    lazy var imageNews: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    lazy var borderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setTitle("\u{2606}", for: .normal)
        button.setTitle("\u{2605}", for: .selected)
        button.setTitleColor(.lightGray, for: .normal)
        button.setTitleColor(.yellow, for: .selected)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        return button
    }()
    
    lazy var buttonTapCallback: () -> ()  = { }
    
    static var identifier = "cell"
    
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        allAddSubview()
        allConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ConfigureConstraints
    
    private  func allConstraints(){
        imageViewConstraints()
        titleLableConstraints()
        dateLabelConstraints()
        borderLineConstraints()
        favoriteButtonConstrains()
        
    }
    private func allAddSubview(){
        addSubview(imageNews)
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(borderLine)
        addSubview(favoriteButton)
    }
    
    private  func imageViewConstraints(){
        imageNews.translatesAutoresizingMaskIntoConstraints = false
        imageNews.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageNews.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -12).isActive = true
        imageNews.heightAnchor.constraint(equalToConstant: 120).isActive = true
        imageNews.widthAnchor.constraint(equalToConstant: 190).isActive = true
    }
    private  func titleLableConstraints(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: imageNews.leadingAnchor, constant: -20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: borderLine.bottomAnchor, constant: -15).isActive = true
    }
    private func dateLabelConstraints(){
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
    }
    private func borderLineConstraints(){
        borderLine.translatesAutoresizingMaskIntoConstraints = false
        borderLine.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: -30).isActive = true
        borderLine.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        borderLine.widthAnchor.constraint(equalToConstant: contentView.frame.width / 2).isActive = true
        borderLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    private func favoriteButtonConstrains(){
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.topAnchor.constraint(equalTo: imageNews.bottomAnchor, constant: 5).isActive = true
        favoriteButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        favoriteButton.centerXAnchor.constraint(equalTo: imageNews.centerXAnchor).isActive = true
        
        favoriteButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    //MARK: @objc
    @objc func didTapButton(){
        buttonTapCallback()
    }
    
    
    
    //MARK: - Ovveride Function
    override func prepareForReuse() {
        super.prepareForReuse()
        imageNews.image = nil
    }
    
    //MARK: - Configure Cell
    func configure(news: News, viewModel: NewsViewModelProtocol){
        //title
        titleLabel.text = news.title
        //date
        dateLabel.text = viewModel.getDate(date: news.publishedAt)
        //image
        if news.urlToImage != nil{
            viewModel.getImage(url: news.urlToImage) { [weak self] image in
                self?.imageNews.image = image
            }
        }else{
            imageNews.image = UIImage(named: "noImage")
        }
        
        
        //button
        bringSubviewToFront(favoriteButton)
        favoriteButton.isSelected = news.isFavorite
        buttonTapCallback = {[weak self] in
            news.isFavorite.toggle()
            if self?.favoriteButton.isSelected == false{
                viewModel.addFavorite(news: news, image: self?.imageNews)
                self?.favoriteButton.isSelected = true
            }else{
                viewModel.deleteFavorite(news: news)
                self?.favoriteButton.isSelected = false
            }
        }
    }
}


