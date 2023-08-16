//
//  MovieModel.swift
//  MovieMania
//
//  Created by Deepshika Ghale on 2023-08-14.
//

import Foundation

struct MovieData: Codable {
    var titles: [MovieModel]
}

struct MovieModel: Codable {
    var jawSummary: JawSummary
//    var episodeCount: Int
}

struct JawSummary: Codable {
    var id: Int
    var isOriginal: Bool
    var title: String
    var synopsis: String
    var releaseYear: Int
}
