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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        switch result {
        case .artist(let model):
            cell.textLabel?.text =  model.name
        case .album(let model):
            cell.textLabel?.text = model.name
        case .track(let model):
            cell.textLabel?.text = model.name
        case .playlist(let model):
            cell.textLabel?.text = model.name
        }
        return cell
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
