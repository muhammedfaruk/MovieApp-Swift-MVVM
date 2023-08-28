//
//  MainVC.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 15.02.2022.
//

import UIKit

protocol MainViewInterface: AnyObject {        
    func configureCollectionView()
    func registerCollectionCells()
    
    func reloadData()
    func startLoading()
    func endLoading()
    func showErrorMessage(message: String)
}

class MainVC: BaseViewController {    
    var collectionView : UICollectionView!
                    
    lazy var viewModel : MainViewModel = MainViewModel()
       
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.homeTitle
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

// MARK: MainViewInterface
extension MainVC: MainViewInterface {
   
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createLayouts())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemGray6
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func registerCollectionCells() {
        collectionView.register(PopularCell.self, forCellWithReuseIdentifier: PopularCell.reuseID)
        collectionView.register(TopRatedCell.self, forCellWithReuseIdentifier: TopRatedCell.reuseID)
        collectionView.register(UpcomingCell.self, forCellWithReuseIdentifier: UpcomingCell.reuseID)
        collectionView.register(LatestCell.self, forCellWithReuseIdentifier: LatestCell.reuseID)
        collectionView.register(HeaderLabelCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderLabelCell.reuseId)
    }
       
    func reloadData(){
        collectionView.reloadData()
    }
        
    func startLoading() {
        showLoading()
    }
    
    func endLoading() {
        hideLoading()
    }
    
    func showErrorMessage(message: String) {
        showAlert(message: message)
    }    
}

extension MainVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
    
    // cell number for sections
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(sectionIndex: section)
    }
    
    // cells in sections
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = viewModel.getSection(indexPath: indexPath)
        
        switch section.cellType {
        case .popular:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.reuseID, for: indexPath) as! PopularCell
            let movie = viewModel.getMovie(indexPath: indexPath)
            cell.setup(movie: movie, itemIndex: (indexPath.item + 1))
            return cell
        case .topRated:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopRatedCell.reuseID, for: indexPath) as! TopRatedCell
            let movie = viewModel.getMovie(indexPath: indexPath)
            cell.setup(movieInfo: movie)
            return cell
        case .upcoming:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingCell.reuseID, for: indexPath) as! UpcomingCell
            let movie = viewModel.getMovie(indexPath: indexPath)
            cell.setup(imagePath: movie.posterPath)
            return cell
        case .latest:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LatestCell.reuseID, for: indexPath) as! LatestCell
            let movie = viewModel.getMovie(indexPath: indexPath)
            cell.setup(imagePath: movie.posterPath)
            return cell
        }
    }
    
    // Headers for sections
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath:IndexPath) -> UICollectionReusableView {
        let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderLabelCell.reuseId, for: indexPath) as! HeaderLabelCell
        headerCell.label.text = viewModel.getSectionTitle(indexPath: indexPath)
        return headerCell
    }
}

extension MainVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailVC()
        detailVC.id = viewModel.getMovieId(indexPath: indexPath)
        navigationController?.pushViewController(detailVC, animated: true)        
    }
}
