//
//  HomeScreen.swift
//  TalkedApp
//
//  Created by Humberto Rodrigues on 05/03/23.
//

import UIKit

class HomeScreen: UIView {
    
    lazy var navView: NavView = {
        let view = NavView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.delaysContentTouches = false //Delay no clique, desabilitado
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        cv.setCollectionViewLayout(layout, animated: false)
        cv.register(LastMessageCollectionViewCell.self, forCellWithReuseIdentifier: LastMessageCollectionViewCell.identifier)
        cv.register(DetailMessageCollectionViewCell.self, forCellWithReuseIdentifier: DetailMessageCollectionViewCell.identifier)
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func collectionDelegate(delegate: UICollectionViewDelegate, datasource: UICollectionViewDataSource) {
        self.collectionView.delegate = delegate
        self.collectionView.dataSource = datasource
    }
    
    public func reloadCollectionView() {
        self.collectionView.reloadData()
    }
    
    private func addSubviews() {
        self.addSubview(self.navView)
        self.addSubview(self.collectionView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            self.navView.topAnchor.constraint(equalTo: self.topAnchor),
            self.navView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.navView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.navView.heightAnchor.constraint(equalToConstant: 140),
            
            self.collectionView.topAnchor.constraint(equalTo: self.navView.bottomAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
