//
//  RecommendedTrackCollectionViewCell.swift
//  SpotifyApp
//
//  Created by Ekrem Özkaraca on 24.08.2021.
//

import UIKit

class RecommendedTrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecommendedTrackCollectionViewCell"
    private let albumCoverImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let trackNameLabel : UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize : 18, weight : .regular)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    private let artistNameLabel : UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize : 15, weight : .thin)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    
    override init (frame : CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize = contentView.height - 70
        artistNameLabel.frame = CGRect(x: albumCoverImageView.right + 10, y: contentView.height / 2, width: contentView.width - albumCoverImageView.right - 15 , height: contentView.height / 2)
        trackNameLabel.frame = CGRect(x: albumCoverImageView.right + 10, y: 0, width: contentView.width - albumCoverImageView.right + 15 , height: contentView.height / 2)
        albumCoverImageView.frame = CGRect(x: 5, y: 2, width: contentView.height - 4, height: contentView.height - 4)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text = nil
        artistNameLabel.text = nil
        albumCoverImageView.image = nil
    }
    
    func configure(with viewModel: RecommendedCellViewModel) {
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        albumCoverImageView.sd_setImage(with: viewModel.artworkUrl, completed: nil)
    }
}
