//
//  DetailVC.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 20.02.2022.
//

import UIKit
import NVActivityIndicatorView

protocol DetailVCInterface: AnyObject {
    func reloadData()
    func startLoading()
    func endLoading()
    func showErrorMessage(message: String)
    func configureHeaderView()
    func configureCollectionView()
    func configureDetailUIElement()
}

class DetailVC: BaseViewController {
    
    var id : Int = 0
    lazy var viewModel = DetailViewModel(service: MovieDetailService(), movieId: id)

    let headerView = UIView()
    var collectionView : UICollectionView!
    var similarMovieTitle = MyLabel(textSize: 30, color: .white, alignment: .left)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        viewModel.view = self
        viewModel.viewDidLoad()
    }               
}


extension DetailVC: DetailVCInterface {
    func reloadData() {
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
    
    func configureDetailUIElement(){
        DispatchQueue.main.async {
            if let detail = self.viewModel.movieDetail {
                let header = DetailVCHeaderVC(detail: detail)
                self.add(childVC: header, containerView: self.headerView)
            }
        }
    }
}

//MARK: - UICollectionViewDataSource
extension DetailVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarCell.reuseID, for: indexPath) as! SimilarCell
        let imagePath  = viewModel.similarMovieAtIndexPath(indexPath: indexPath).posterPath
        cell.setup(imagePath: imagePath)
        return cell
    }
    
}

//MARK: - UICollectionViewDelegate
extension DetailVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailVC()
        detailVC.id = viewModel.similarMovieAtIndexPath(indexPath: indexPath).id
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

