//
//  LibraryPlaylistViewController.swift
//  SpotifyApp
//
//  Created by Ekrem Özkaraca on 13.10.2021.
//

import UIKit

class LibraryPlaylistViewController: UIViewController {
    
    var playlists = [Playlist]()
    private let noPlaylistView = ActionLabelView()
    
    private let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SearchResultSubtitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifier)
        tableView.isHidden = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(noPlaylistView)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        setUpNoPlaylistView()
        fetchData()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noPlaylistView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        tableView.frame = view.bounds
        noPlaylistView.center = view.center
    }
    
    private func fetchData () {
        APICaller.shared.getCurrentUserPlaylist { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let playlists):
                    self?.playlists = playlists
                    self?.updateUI()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    private func setUpNoPlaylistView() {
        noPlaylistView.delegate = self
        noPlaylistView.configure(with: ActionLabelViewViewModel(text: "You dont have any playlist yet", actionTitle: "Create"))
    }
    
    private func updateUI() {
        if playlists.isEmpty {
            //            show label
            noPlaylistView.isHidden = false
            tableView.isHidden = true
            
        } else {
            //            show table
            tableView.reloadData()
            noPlaylistView.isHidden = true
            tableView.isHidden = false
            
        }
    }
    
    
    public func showCreatePlaylistAlert() {
        
        let alert = UIAlertController(title: "New Playlist", message: "Enter playlist name", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Playlist..."
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: {_ in
            guard let field = alert.textFields?.first, let text = field.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else {return}
            
            APICaller.shared.createPlaylist(with: text) { success in
                if success {
                    self.fetchData()
                } else {
                    print("Failed to create playlist..")
                }
            }
        }))
        
        present(alert, animated: true)
    }
}
extension LibraryPlaylistViewController : ActionLabelViewDelegate {
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        // show creation ui
        showCreatePlaylistAlert()
    }
}

extension LibraryPlaylistViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.identifier, for: indexPath) as? SearchResultSubtitleTableViewCell else {return UITableViewCell()}
        let playlist = playlists[indexPath.row]
        cell.configure(with: SearchResultSubtitleTableViewCellViewModel(title: playlist.name, subTitle: playlist.owner.display_name, imageURL: URL(string: playlist.images.first?.url ?? "")))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
