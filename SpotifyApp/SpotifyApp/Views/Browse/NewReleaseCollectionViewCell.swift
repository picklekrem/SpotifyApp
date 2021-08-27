//
//  NewReleaseCollectionViewCell.swift
//  SpotifyApp
//
//  Created by Ekrem Özkaraca on 24.08.2021.
//

import UIKit
import SDWebImage

class NewReleaseCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewReleaseCollectionViewCell"
    
    private let albumCoverImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let albumNameLabel : UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize : 20, weight : .semibold)
        label.numberOfLines = 0
        return label
    }()
    private let artistNameLabel : UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize : 18, weight : .regular)
        label.numberOfLines = 0
        return label
    }()
    private let numberOfTrackLabel : UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize : 18, weight : .light)
        label.numberOfLines = 0
        return label
    }()
    
    
    override init (frame : CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.addSubview(numberOfTrackLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize : CGFloat = contentView.height - 10
        let albumLabelSize = albumNameLabel.sizeThatFits(CGSize(width: contentView.width-imageSize-10, height: contentView.height-10))
        let albumLabelHeight = min(60, albumLabelSize.height)

        artistNameLabel.sizeToFit()
        numberOfTrackLabel.sizeToFit()
        albumCoverImageView.frame = CGRect(x: 5, y: 5, width: imageSize, height: imageSize)
        
        albumNameLabel .frame = CGRect(x: albumCoverImageView.right + 10, y: 5,
                                       width: albumLabelSize.width, height: albumLabelHeight)
        
        numberOfTrackLabel.frame = CGRect(x: albumCoverImageView.right + 10, y: contentView.bottom - 44,
                                          width: numberOfTrackLabel.width, height: 44)
        
        artistNameLabel.frame = CGRect(x: albumCoverImageView.right + 10, y: albumNameLabel.bottom,
                                       width: contentView.width - albumCoverImageView.right - 10, height: 30)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumNameLabel.text = nil
        artistNameLabel.text = nil
        numberOfTrackLabel.text = nil
        albumCoverImageView.image = nil
    }
    
    func configure(with viewModel: NewReleasesCellViewModel) {
        albumNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        numberOfTrackLabel.text = "Tracks: \(viewModel.numberOfTracks)"
        albumCoverImageView.sd_setImage(with: viewModel.artworkUrl, completed: nil)
    }
    
}


