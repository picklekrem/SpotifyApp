//
//  PlaylistViewController.swift
//  SpotifyApp
//
//  Created by Ekrem Özkaraca on 19.08.2021.
//

import UIKit

class PlaylistViewController: UIViewController{
    
    private let playlist: Playlist
    private var viewModels = [RecommendedCellViewModel]()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ ->NSCollectionLayoutSection? in
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                             heightDimension: .fractionalHeight(1.0)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 1, trailing: 2)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                        heightDimension: .absolute(60)),
                                                     subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        ]
        return section
    }))
    
    init(playlist: Playlist) {
        self.playlist = playlist
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        title = playlist.name
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(PlaylistHeaderCollectionReusableView.self,forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PlaylistHeaderCollectionReusableView.identifier)
        collectionView.register(RecommendedTrackCollectionViewCell.self, forCellWithReuseIdentifier: RecommendedTrackCollectionViewCell.identifier)
        
        APICaller.shared.getPlaylistDetails(for: playlist) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    //Recommended track cell
                    self?.viewModels = model.tracks.items.compactMap({ RecommendedCellViewModel(name: $0.track.name, artistName: $0.track.artists.first?.name ?? "", artworkUrl: URL(string: $0.track.album?.images.first?.url ?? ""))
                    })
                    self?.collectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    @objc private func didTapShare() {
        guard let url = URL(string: playlist.external_urls["spotify"] ?? "") else {return}
        
        print(playlist.external_urls)
        let vc = UIActivityViewController(activityItems: [url], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
}
extension PlaylistViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:RecommendedTrackCollectionViewCell.identifier , for: indexPath) as? RecommendedTrackCollectionViewCell else {return UICollectionViewCell()}
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        //play song
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PlaylistHeaderCollectionReusableView.identifier, for: indexPath) as? PlaylistHeaderCollectionReusableView,
              kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        let headerViewModel = PlaylistHeaderViewModel(name: playlist.name, ownerName: playlist.owner.display_name, description: playlist.description, artworkURL: URL(string: playlist.images.first?.url ?? ""))
        header.configure(with: headerViewModel)
        header.delegate = self
        return header
    
    }

}


extension PlaylistViewController : PlaylistHeaderCollectionReusableViewDelegate {
    func playlistHeaderCollectionReusableViewDidTapPlayAll(_ header: PlaylistHeaderCollectionReusableView) {
        //start playlist play in queue
        print("print all")
    }
}
