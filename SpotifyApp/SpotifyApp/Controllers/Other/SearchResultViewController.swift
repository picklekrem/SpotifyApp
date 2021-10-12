//
//  SearchResultViewController.swift
//  SpotifyApp
//
//  Created by Ekrem Özkaraca on 19.08.2021.
//

import UIKit

struct SearchSection {
    let title : String
    let result : [SearchResult]
}

protocol SearchResultViewControllerDelegate : AnyObject {
    func didTapResult(_ result: SearchResult)
}
class SearchResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    weak var delegate: SearchResultViewControllerDelegate?
    
    private var sections : [SearchSection] = []
    
    private var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .systemBackground
        tableView.register(SearchResultDefaultTableViewCell.self, forCellReuseIdentifier: SearchResultDefaultTableViewCell.identifier)
        tableView.register(SearchResultSubtitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifier)
        tableView.isHidden = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .clear
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func update(with results: [SearchResult]){
        let artists = results.filter({
            switch $0 {
            case .artist: return true
            default : return false
            }
        })
        let albums = results.filter({
            switch $0 {
            case .album: return true
            default : return false
            }
        })
        let tracks = results.filter({
            switch $0 {
            case .track: return true
            default : return false
            }
        })
        let playlist = results.filter({
            switch $0 {
            case .playlist: return true
            default : return false
            }
        })
        self.sections = [SearchSection(title: "Artist", result: artists),
                         SearchSection(title: "Albums", result: albums),
                         SearchSection(title: "Tracks", result: tracks),
                         SearchSection(title: "Playlist", result: playlist)]
        tableView.reloadData()
        tableView.isHidden = results.isEmpty
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result = sections[indexPath.section].result[indexPath.row]
        switch result {
        case .artist(let artistModel):
            guard let artistCell  = tableView.dequeueReusableCell(withIdentifier: SearchResultDefaultTableViewCell.identifier, for: indexPath) as? SearchResultDefaultTableViewCell else { return UITableViewCell() }
            let viewModel = SearchResultDefaultTableViewCellViewModel(title: artistModel.name, imageURL: URL(string: artistModel.images?.first?.url ?? ""))
            artistCell.configure(with: viewModel)
            return artistCell
            
        case .album(let albumModel):
            guard let albumCell  = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.identifier, for: indexPath) as? SearchResultSubtitleTableViewCell else { return UITableViewCell() }
            let viewModel = SearchResultSubtitleTableViewCellViewModel(title: albumModel.name, subTitle: albumModel.artists.first?.name ?? "", imageURL : URL(string: albumModel.images.first?.url ?? ""))
            albumCell.configure(with: viewModel)
            return albumCell
            
            case .track(let trackModel):
                guard let trackCell  = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.identifier, for: indexPath) as? SearchResultSubtitleTableViewCell else { return UITableViewCell() }
                let viewModel = SearchResultSubtitleTableViewCellViewModel(title: trackModel.name, subTitle: trackModel.artists.first?.name ?? "", imageURL : URL(string: trackModel.album?.images.first?.url ?? ""))
                trackCell.configure(with: viewModel)
                return trackCell
                
        case .playlist(let playlistModel):
            guard let playlistCell  = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.identifier, for: indexPath) as? SearchResultSubtitleTableViewCell else { return UITableViewCell() }
            let viewModel = SearchResultSubtitleTableViewCellViewModel(title: playlistModel.name, subTitle: playlistModel.owner.display_name, imageURL : URL(string: playlistModel.images.first?.url ?? ""))
            playlistCell.configure(with: viewModel)
            return playlistCell
        }
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let result = sections[indexPath.section].result[indexPath.row]
        delegate?.didTapResult(result)
    }
}
