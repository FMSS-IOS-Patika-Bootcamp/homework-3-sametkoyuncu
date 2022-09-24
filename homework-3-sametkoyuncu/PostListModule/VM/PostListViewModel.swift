//
//  PostListViewModel.swift
//  homework-3-sametkoyuncu
//
//  Created by Samet Koyuncu on 19.09.2022.
//

import Foundation

protocol PostListViewModelViewProtocol: AnyObject {
    func didCellItemFetch(isSuccess: Bool)
    // TODO:
    func showEmptyView()
    func hideEmptyView()
}

class PostListViewModel {
    private let model = PostListModel()
    
    weak var viewDelegate: PostListViewModelViewProtocol?
    
    init() {
        model.delegate = self
    }
    
    // view yüklendiyse data çek
    func didViewLoad() {
        model.fetchData()
    }
    
    func NumberOfItems() -> Int {
        return model.posts.count
    }
    
    func getModel(at index: Int) -> PostCellViewModel {
        let post = model.posts[index]
        
        return transformPostToPostListModel(from: post)
    }
    
    private func transformPostToPostListModel(from post: Post) -> PostCellViewModel {
        return PostCellViewModel(post.title, post.body)
    }
    
    // derste yazdık, ama kullanmadık
    func didClickItem(at index: Int) {
        let _ = model.posts[index]
        print("selected index: \(index)")
        // TODO: navigate
    }
}

// MARK: - PostListModel Delegate Methods
extension PostListViewModel: PostListModelProtocol {
    func didDataFetchProcessFinish(_ isSuccess: Bool) {
        if isSuccess {
            viewDelegate?.hideEmptyView()
            viewDelegate?.didCellItemFetch(isSuccess: true)
        } else {
            // TODO:
            viewDelegate?.showEmptyView()
        }
    }
}
