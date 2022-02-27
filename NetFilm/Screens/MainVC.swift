//
//  MainVC.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 15.02.2022.
//

import UIKit
import NVActivityIndicatorView

protocol MainVCOutPut: AnyObject {
    func saveMovies(movieType:MovieTypes, list: [MovieInfo])
    func changeLoadingAndReloadData(isLoading: Bool)
}

class MainVC: UIViewController {
    
    var collectionView : UICollectionView!
    
    var collectionCells = [CellItem]()
    
    var popularMovieList   : [MovieInfo] = []
    var topRatedMovieList  : [MovieInfo] = []
    var upcomingMoviesList : [MovieInfo] = []
    var latestMoviesList   : [MovieInfo] = []
    
    lazy var viewModel : MainViewModel = MainViewModel()
    
    var activityIndicatorView = NVActivityIndicatorView(frame: .zero, type: .circleStrokeSpin, color: .systemRed, padding: 0)
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        makeDarkModeAllView()
        configureCells()
        
        viewModel.mainVCOutPut = self
        viewModel.fetchData()
        
        configureCollectionView()
        registerOurCells()
        configureIndicatorView()
    }
      
    
    func configureCells(){
        collectionCells = [CellItem(cellType: .popularMovies, movieList: popularMovieList),
                           CellItem(cellType: .topRatedMovies, movieList: topRatedMovieList),
                           CellItem(cellType: .latestMovies, movieList: latestMoviesList),
                           CellItem(cellType: .upcomingMovies, movieList: upcomingMoviesList)]
    }
    
    func configureIndicatorView(){
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicatorView)
        activityIndicatorView.pintoCenter(superView: view)
    }
   
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createLayouts())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemGray6
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func registerOurCells(){
        collectionView.register(PopularCell.self, forCellWithReuseIdentifier: PopularCell.reuseID)
        collectionView.register(TopRatedCell.self, forCellWithReuseIdentifier: TopRatedCell.reuseID)
        collectionView.register(UpcomingCell.self, forCellWithReuseIdentifier: UpcomingCell.reuseID)
        collectionView.register(LatestCell.self, forCellWithReuseIdentifier: LatestCell.reuseID)
        collectionView.register(HeaderLabelCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderLabelCell.reuseId)
    }
            
}

// MARK: ViewModel OutPuts
extension MainVC: MainVCOutPut {
    
    // save movies with type
    func saveMovies(movieType: MovieTypes, list: [MovieInfo]) {
        switch movieType {
        case .popularMovies:
            popularMovieList = list
        case .topRatedMovies:
            topRatedMovieList = list
        case .upcomingMovies:
            upcomingMoviesList = list
        case .latestMovies:
            latestMoviesList = list
        }
        configureCells()
    }
    
    func changeLoadingAndReloadData(isLoading: Bool) {
        if isLoading {
            activityIndicatorView.startAnimating()
            print("Yükleniyor..")
        }else {
            print("Yüklendi")
            activityIndicatorView.stopAnimating()
            collectionView.reloadData()
        }
    }
       
}

extension MainVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collectionCells.count
    }
    
    // cell number for sections
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionCells[section].movieList.count
    }
    
    // cells in sections
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = collectionCells[indexPath.section]
        
        switch section.cellType {
            
        case .popularMovies:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.reuseID, for: indexPath) as! PopularCell
            let movie = self.popularMovieList[indexPath.item]
            cell.setup(movie: movie, itemIndex: (indexPath.item + 1))
            return cell
        case .topRatedMovies:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopRatedCell.reuseID, for: indexPath) as! TopRatedCell
            let movie = topRatedMovieList[indexPath.item]
            cell.setup(movieInfo: movie)
            return cell
        case .upcomingMovies:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingCell.reuseID, for: indexPath) as! UpcomingCell
            let image = upcomingMoviesList[indexPath.item].posterPath
            cell.setup(imagePath: image)
            return cell
        case .latestMovies:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LatestCell.reuseID, for: indexPath) as! LatestCell
            let image = latestMoviesList[indexPath.item].posterPath
            cell.setup(imagePath: image)
            return cell
        }
    }
    
    // Headers for sections
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderLabelCell.reuseId, for: indexPath) as! HeaderLabelCell
        headerCell.label.text = MovieTypes.allCases[indexPath.section].rawValue
        return headerCell
    }
}

extension MainVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let detailVC = DetailVC()
        detailVC.id = collectionCells[indexPath.section].movieList[indexPath.item].id
        navigationController?.pushViewController(detailVC, animated: true)        
    }
}
