//
//  TitleHeaderCollectionReusableView.swift
//  SpotifyApp
//
//  Created by Ekrem Özkaraca on 14.09.2021.
//

import UIKit

class TitleHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "TitleHeaderCollectionReusableView"
    
    private let label : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(label)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 15, y: 0, width: width-30, height: height)
    }
    
    func configure(with title : String){
        label.text = title
    }
}
