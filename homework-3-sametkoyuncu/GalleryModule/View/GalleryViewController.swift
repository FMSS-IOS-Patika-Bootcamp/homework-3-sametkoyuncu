//
//  GalleryViewController.swift
//  homework-3-sametkoyuncu
//
//  Created by Samet Koyuncu on 19.09.2022.
//

import UIKit
import Kingfisher

class GalleryViewController: UIViewController {
    
    private let galleryCellReuseIdentifier = "galleryCollectionViewCell"
    private let headerCellReuseIdentifier = "headerCollectionViewCell"
    
    private let viewModel = GalleryViewModel()
    
    private var items: [GalleryCellViewModel] = []

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = false
        
        viewModel.viewDelegate = self
        viewModel.didViewLoad()
    }
    
    func registerCells() {
        collectionView.register(.init(nibName: "GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: galleryCellReuseIdentifier)
        
        collectionView.register(.init(nibName: "HeaderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: headerCellReuseIdentifier)
    }
}

// MARK: - GalleryModel Delegate Methods
extension GalleryViewController: GalleryViewModelViewProtocol {
    func didCellItemFetch(_ items: [GalleryCellViewModel]) {
        self.items = items
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

// MARK: - CollectionView Delegate - Kullanmıyoruz
extension GalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO:
    }
}

// MARK: - CollectionView DataSource
extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // show header cell
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: headerCellReuseIdentifier, for: indexPath) as! HeaderCollectionViewCell
            
            return cell
        }
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: galleryCellReuseIdentifier, for: indexPath) as! GalleryCollectionViewCell
        let url = URL(string: items[indexPath.row - 1].url!)
        cell.cellImage.kf.setImage(with: url)
        
        return cell
    }
    
}

// set cell width using device sizes

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // header cell
        if indexPath.row == 0 {
            let width = collectionView.frame.width - 20
            let height = 75.0
            
            return CGSize(width: width, height: height)
        }

        // for large screens, 4 column
        if collectionView.frame.width > 340 {
            let width = (collectionView.frame.width - 40) / 4
            let height = width
            
            return CGSize(width: width, height: height)
        }
        // for small screens, 3 column
        let width = (collectionView.frame.width - 35) / 3
        let height = width
        
        return CGSize(width: width, height: height)
        
    }
}

