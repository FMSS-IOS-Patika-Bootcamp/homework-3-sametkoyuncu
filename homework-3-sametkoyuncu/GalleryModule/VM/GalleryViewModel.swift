//
//  GalleryViewModel.swift
//  homework-3-sametkoyuncu
//
//  Created by Samet Koyuncu on 19.09.2022.
//

import Foundation

protocol GalleryViewModelViewProtocol: AnyObject {
    func didCellItemFetch(isSuccess: Bool)
}

class GalleryViewModel {
    private let model = GalleryModel()
    
    weak var viewDelegate: GalleryViewModelViewProtocol?
    
    init() {
        model.delegate = self
    }
    
    // view yüklendiyse data çek
    func didViewLoad() {
        model.fetchData()
    }
    
    func numberOfItems() -> Int {
        return model.photos.count
    }
    
    func getModel(at index: Int) -> GalleryCellViewModel {
        let photo = model.photos[index]
        
        return transformPhotoToGalleryCellViewModel(from: photo)
    }
    
    private func transformPhotoToGalleryCellViewModel(from photo: Photo) -> GalleryCellViewModel {
        return GalleryCellViewModel(photo.url, photo.thumbnailUrl)
    }
}

// MARK: - GalleryModel Delegate Methods
extension GalleryViewModel: GalleryModelProtocol {
    func didDataFetchProcessFinish(_ isSuccess: Bool) {
        if isSuccess {
            viewDelegate?.didCellItemFetch(isSuccess: true)
        } else {
            // TODO:
            print("didDataFetchProcessFinish, false geldi.")
        }
        
    }
}
