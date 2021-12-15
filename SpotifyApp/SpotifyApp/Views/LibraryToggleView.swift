//
//  LibraryToggleView.swift
//  SpotifyApp
//
//  Created by Ekrem Özkaraca on 14.10.2021.
//

import UIKit

protocol LibraryToggleViewDelegate : AnyObject {
    func libraryToggleViewDidTapPlaylists( _ toggleView : LibraryToggleView)
    func libraryToggleViewDidTapAlbums(_ toggleView : LibraryToggleView)
}

class LibraryToggleView: UIView {
    
    enum State {
        case playlist
        case album
    }
    
    var state : State = .playlist
    
    weak var delegate : LibraryToggleViewDelegate?
    
    private let playlistButton : UIButton = {
        let button = UIButton()
        button.setTitle("Playlists", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let albumButton : UIButton = {
        let button = UIButton()
        button.setTitle("Albums", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let indicatorView : UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(playlistButton)
        addSubview(albumButton)
        addSubview(indicatorView)
        
        playlistButton.addTarget(self, action: #selector(didTapPlaylist), for: .touchUpInside)
        albumButton.addTarget(self, action: #selector(didTapAlbum), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError()
        
    }
    
    @objc func didTapPlaylist() {
        delegate?.libraryToggleViewDidTapPlaylists(self)
        state = .playlist
        UIView.animate(withDuration: 0.2, animations: {
            self.layoutIndicator()
        })
    }
    
    @objc func didTapAlbum() {
        delegate?.libraryToggleViewDidTapAlbums(self)
        state = .album
        UIView.animate(withDuration: 0.2, animations: {
            self.layoutIndicator()
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playlistButton.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        albumButton.frame = CGRect(x: playlistButton.right, y: 0, width: 100, height: 40)
        layoutIndicator()
    }
    
    func layoutIndicator() {
        switch state {
        case .playlist:
            indicatorView.frame = CGRect(x: 0, y: playlistButton.bottom, width: 100, height: 3)
        case .album:
            indicatorView.frame = CGRect(x: 110, y: playlistButton.bottom, width: 80, height: 3)
        }
    }
    
    func updateForState(state : State) {
        self.state = state
        UIView.animate(withDuration: 0.2, animations: {
            self.layoutIndicator()
        })
    }
}
