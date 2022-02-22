//
//  DetailVCHeaderViewViewController.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 21.02.2022.
//

import UIKit

class DetailVCHeaderVC: UIViewController {

    let posterImage = MyImage(frame: .zero)
    let titleLabel = MyLabel(textSize: 25, color: .white, alignment: .left)
    let overViewLabel = MyBodyLabel(textAlignment: .left)
    
    let genre = DetailHeaderContentView()
    let runTime = DetailHeaderContentView()
    let date = DetailHeaderContentView()
    
    let stackView = UIStackView()
    
    var detail : MovieDetail!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        set()
    }
    
    init(detail : MovieDetail){
        super.init(nibName: nil, bundle: nil)
        self.detail = detail
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(){
        genre.setLabelText(text: detail.genres[0].name, systemImage: "tag")
        runTime.setLabelText(text: timeConverter(runtime: detail.runtime), systemImage: "clock")
        date.setLabelText(text: dateConverter(date: detail.releaseDate), systemImage: "calendar")
        overViewLabel.text = detail.overview
        posterImage.downloadImage(posterPath: detail.posterPath)
        titleLabel.text = detail.title
    }
    
    func configureStackView(){
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(genre)
        stackView.addArrangedSubview(runTime)
        stackView.addArrangedSubview(date)
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }

    func configureLayout(){
        
        view.addSubViews(view: posterImage, titleLabel, stackView, overViewLabel)
        
        configureStackView()
        
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: view.topAnchor),
            posterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            posterImage.widthAnchor.constraint(equalToConstant: 100),
            posterImage.heightAnchor.constraint(equalToConstant: 180),
            
            titleLabel.topAnchor.constraint(equalTo: posterImage.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 40),
            
            overViewLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 10),
            overViewLabel.leadingAnchor.constraint(equalTo: posterImage.leadingAnchor),
            overViewLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),            
            
        ])
        titleLabel.sizeToFit()
    }
    
    
    func timeConverter(runtime: Int) -> String {
        let hour = runtime / 60
        let minute = runtime - (hour * 60)
        let result = "\(hour)h \(minute)m"
        
        return result
    }
    
    func dateConverter(date: String) -> String {
        
        let str = Array(date)
        var result = ""
        
        for i in 0...3 {
            result += String(str[i])
        }
        
        return result
    }

}
