//
//  DetailVC.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 20.02.2022.
//

import UIKit
import NVActivityIndicatorView

protocol DetailVCOutPut: AnyObject {
    func saveDetails(detail: MovieDetail)
    func saveSimilarMovies(movies: [MovieInfo])
    func changeisLoading(isloading : Bool)
}

class DetailVC: UIViewController {
    
    var id : Int = 0    
    let headerView = UIView()
    lazy var viewModel : DetailViewModel = DetailViewModel()
    
    var collectionView : UICollectionView!
    var similarMovieTitle = MyLabel(textSize: 30, color: .white, alignment: .left)
    
    var similarMovieList : [MovieInfo] = []
    
    var activityIndicatorView = NVActivityIndicatorView(frame: .zero, type: .circleStrokeSpin, color: .systemRed, padding: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        viewModel.detailOutPut = self
        viewModel.fetchDetail(movieID: id)
        viewModel.fetchSimilarMovies(movieID: id)
        configureIndicatorView()
        configureHeaderView()
        configureCollectionView()
    }
    
       
    func configureCollectionView(){
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createColumnFlowLayout(view: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SimilarCell.self, forCellWithReuseIdentifier: SimilarCell.reuseID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: similarMovieTitle.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
        
    func configureIndicatorView(){
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicatorView)
        activityIndicatorView.pintoCenter(superView: view)
    }

    func configureHeaderView() {
        view.addSubview(headerView)
        view.addSubview(similarMovieTitle)
        similarMovieTitle.text = "Similar Movies"
        headerView.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 10),
            headerView.heightAnchor.constraint(equalToConstant: 350),
            
            similarMovieTitle.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 50),
            similarMovieTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            similarMovieTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 10),
            similarMovieTitle.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    func configureUIElement(detail: MovieDetail){
        DispatchQueue.main.async {
            let header = DetailVCHeaderVC(detail: detail)
            self.add(childVC: header, containerView: self.headerView)
        }
        
    }
    
    
    func add(childVC : UIViewController, containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}


extension DetailVC: DetailVCOutPut {
    
    func saveSimilarMovies(movies: [MovieInfo]) {
        DispatchQueue.main.async {
            self.similarMovieList = movies
            self.collectionView.reloadData()
        }
    }
    
    func changeisLoading(isloading: Bool) {
        isloading ? activityIndicatorView.startAnimating() : activityIndicatorView.stopAnimating()
        
        if isloading {
            print("detay yuklemiyor")
            activityIndicatorView.startAnimating()
        }else {
            print("detay yuklendi")
            activityIndicatorView.stopAnimating()
        }
    }
    
    
    func saveDetails(detail: MovieDetail) {
        configureUIElement(detail: detail)
    }
}

extension DetailVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarMovieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarCell.reuseID, for: indexPath) as! SimilarCell
        let imagePath  = similarMovieList[indexPath.item].posterPath
        cell.setup(imagePath: imagePath)
        return cell
    }
    
}

extension DetailVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailVC()
        detailVC.id = similarMovieList[indexPath.item].id
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
}

