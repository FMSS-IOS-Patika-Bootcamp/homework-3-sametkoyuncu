//
//  GalleryEntity.swift
//  homework-3-sametkoyuncu
//
//  Created by Samet Koyuncu on 19.09.2022.
//

import Foundation

class GalleryCellViewModel {
    var url: String?
    var thumbnailUrl: String?
    
    init(_ url: String?, _ thumbnailUrl: String?) {
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }
}

struct Photo: Decodable {
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
}
