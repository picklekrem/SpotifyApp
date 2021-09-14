//
//  GenreCollectionViewCell.swift
//  SpotifyApp
//
//  Created by Ekrem Özkaraca on 14.09.2021.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    static let identifier = "GenreCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "music.quarternote.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        return imageView
    }()
    
    private let label : UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let colors : [UIColor] = [
        .systemBlue, .systemRed, .systemPink, .systemTeal, .systemGreen, .systemYellow, .systemPurple, .systemOrange, .systemIndigo, .brown, .cyan, .magenta
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        addSubview(imageView)
        addSubview(label)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 10, y: contentView.height/2, width: contentView.width-20, height: contentView.height/2)
        imageView.frame = CGRect(x: contentView.width/2, y: 0, width: contentView.width/2, height: contentView.height/2)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    func configure (with title: String) {
        label.text = title
        contentView.backgroundColor = colors.randomElement()
    }
    
}
