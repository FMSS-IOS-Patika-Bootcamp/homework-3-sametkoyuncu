//
//  GalleryViewModel.swift
//  homework-3-sametkoyuncu
//
//  Created by Samet Koyuncu on 19.09.2022.
//

import Foundation

protocol GalleryViewModelViewProtocol: AnyObject {
    func didCellItemFetch(_ items: [GalleryCellViewModel])
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
    
    //
    func didClickItem(at index: Int) {
        let selectedItem = model.photos[index]
        // TODO: navigate
    }
}

private extension GalleryViewModel {
    
    @discardableResult
    func makeViewBasedModel(_ photos: [Photo]) -> [GalleryCellViewModel] {
        photos.map { .init($0.url, $0.thumbnailUrl) }
    }
}

// MARK: - GalleryModel Delegate Methods
extension GalleryViewModel: GalleryModelProtocol {
    func didDataFetchProcessFinish(_ isSuccess: Bool) {
        if isSuccess {
            let photos = model.photos
            let filteredArray = photos.filter { $0.id <= 100 }
            
            let cellModels = makeViewBasedModel(filteredArray)
            
            viewDelegate?.didCellItemFetch(cellModels)
        } else {
            // TODO:
            print("didDataFetchProcessFinish, false geldi.")
        }
        
    }
}
