//
//  LibraryAlbumsViewController.swift
//  SpotifyApp
//
//  Created by Ekrem Özkaraca on 13.10.2021.
//

import UIKit

class LibraryAlbumsViewController: UIViewController {
    
    var albums = [Album]()
    private let noAlbumsView = ActionLabelView()
    
    private let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SearchResultSubtitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifier)
        tableView.isHidden = true
        return tableView
    }()
    
    private var observer: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(noAlbumsView)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        setUpNoAlbumsView()
        fetchData()
        observer = NotificationCenter.default.addObserver(
                  forName: .albumSavedNotification,
                  object: nil,
                  queue: .main,
                  using: { [weak self] _ in
                      self?.fetchData()
                  }
              )
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noAlbumsView.frame = CGRect(x: (view.width - 150) / 2, y: (view.height - 150) / 2, width: 150, height: 150)
        tableView.frame = view.bounds
    }
    
    @objc func didTapClose() {
        dismiss(animated: true)
    }
    
    private func fetchData () {
        albums.removeAll()
        APICaller.shared.getCurrentUserAlbums { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let albums):
                    self?.albums = albums
                    self?.updateUI()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }

    }
    
    private func setUpNoAlbumsView(){
        noAlbumsView.delegate = self
        noAlbumsView.configure(with: ActionLabelViewViewModel(text: "You dont have any saved albums yet", actionTitle: "Browse"))
    }
    
    private func updateUI() {
        if albums.isEmpty {
            //            show label
            noAlbumsView.isHidden = false
            tableView.isHidden = true
            
        } else {
            //            show table
            tableView.reloadData()
            noAlbumsView.isHidden = true
            tableView.isHidden = false
            
        }
    }

}
extension LibraryAlbumsViewController : ActionLabelViewDelegate {
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        tabBarController?.selectedIndex = 0
    }
}

extension LibraryAlbumsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.identifier, for: indexPath) as? SearchResultSubtitleTableViewCell else {return UITableViewCell()}
        let album = albums[indexPath.row]
        cell.configure(with: SearchResultSubtitleTableViewCellViewModel(title: album.name, subTitle: album.artists.first?.name ?? "-", imageURL: URL(string: album.images.first?.url ?? "")))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let album = albums[indexPath.row]
       
        let vc = AlbumViewController(album: album)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
