//
//  PostListEntity.swift
//  homework-3-sametkoyuncu
//
//  Created by Samet Koyuncu on 19.09.2022.
//

import Foundation

class PostCellViewModel {
    var title: String?
    var desc: String?
    
    init(_ title: String?, _ desc: String?) {
        self.title = title
        self.desc = desc
    }
}

struct Post: Decodable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}
