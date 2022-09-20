//
//  PostListModel.swift
//  homework-3-sametkoyuncu
//
//  Created by Samet Koyuncu on 19.09.2022.
//

import Foundation

protocol PostListModelProtocol: AnyObject {
    func didDataFetchProcessFinish(_ isSuccess: Bool)
}

class PostListModel {
    weak var delegate: PostListModelProtocol?
    
    var posts: [Post] = []
    
    func fetchData() {
        // TODO:
        guard let url = URL.init(string: "https://jsonplaceholder.typicode.com/posts") else {
            delegate?.didDataFetchProcessFinish(false)
            return
        }
        
        var request: URLRequest = .init(url: url)
        
        // default method get
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
            // error handling
            guard let self = self else { return }
            
            guard error == nil else {
                self.delegate?.didDataFetchProcessFinish(false)
                return
            }
            
            let statusCode = (response as! HTTPURLResponse).statusCode
            
            guard statusCode >= 200,
                  statusCode < 300 else {
                self.delegate?.didDataFetchProcessFinish(false)
                return
            }
            
            // decode data
            do {
                let responseModel = try JSONDecoder().decode([Post].self, from: data!)
                self.posts = responseModel
                self.delegate?.didDataFetchProcessFinish(true)
                
            } catch {
                self.delegate?.didDataFetchProcessFinish(false)
            }
        }
        
        task.resume()
    }
}

