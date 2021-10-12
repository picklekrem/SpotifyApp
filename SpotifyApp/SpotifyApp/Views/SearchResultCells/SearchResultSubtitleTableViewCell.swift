//
//  SearchResultDefaultTableViewCell.swift
//  SpotifyApp
//
//  Created by Ekrem Özkaraca on 20.09.2021.
//

import UIKit
import SDWebImage

class SearchResultSubtitleTableViewCell: UITableViewCell {

    private let label : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let subLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let iconImageView : UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    static let identifier = "SearchResultSubtitleTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(iconImageView)
        contentView.addSubview(subLabel)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize : CGFloat = contentView.height - 10
        iconImageView.frame = CGRect(x: 10, y: 5, width: imageSize, height: imageSize)
        let labelHeight = contentView.height / 2
        label.frame = CGRect(x: iconImageView.right + 10 , y: 0, width: contentView.width - iconImageView.right - 15, height: labelHeight)
        subLabel.frame = CGRect(x: iconImageView.right + 10 , y: label.bottom, width: contentView.width - iconImageView.right - 15, height: labelHeight)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        subLabel.text = nil
    }
    
    func configure(with viewModel : SearchResultSubtitleTableViewCellViewModel) {
        label.text = viewModel.title
        subLabel.text = viewModel.subTitle
        imageView?.sd_setImage(with: viewModel.imageURL, completed: nil)
    }
}
