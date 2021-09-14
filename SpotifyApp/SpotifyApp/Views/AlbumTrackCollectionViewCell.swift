//
//  AlbumTrackCollectionViewCell.swift
//  SpotifyApp
//
//  Created by Ekrem Özkaraca on 14.09.2021.
//

import Foundation
import UIKit

class AlbumTrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "AlbumTrackCollectionViewCell"
    
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
        artistNameLabel.frame = CGRect(x: 10, y: contentView.height / 2, width: contentView.width - 15 , height: contentView.height / 2)
        trackNameLabel.frame = CGRect(x: 10, y: 0, width: contentView.width - 15 , height: contentView.height / 2)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text = nil
        artistNameLabel.text = nil
        
    }
    
    func configure(with viewModel: AlbumCollectionViewCellViewModel) {
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
    }
}
