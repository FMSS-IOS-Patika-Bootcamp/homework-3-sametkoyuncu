//
//  GalleryModel.swift
//  homework-3-sametkoyuncu
//
//  Created by Samet Koyuncu on 19.09.2022.
//

import Foundation

protocol GalleryModelProtocol: AnyObject {
    func didDataFetchProcessFinish(_ isSuccess: Bool)
}

class GalleryModel {
    weak var delegate: GalleryModelProtocol?
    
    var photos: [Photo] = []
    
    func fetchData() {
        // TODO:
        guard let url = URL.init(string: "https://jsonplaceholder.typicode.com/photos") else {
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
                let responseModel = try JSONDecoder().decode([Photo].self, from: data!)
                self.photos = responseModel.filter { $0.id <= 100 }
                self.delegate?.didDataFetchProcessFinish(true)
                
            } catch {
                self.delegate?.didDataFetchProcessFinish(false)
            }
        }
        
        task.resume()
    }
}

