//
//  Similar.swift
//  SeSAC3Week5
//
//  Created by 이승현 on 2023/08/20.
//

import Foundation

// MARK: - Similar
struct Similar: Codable {
    let page: Int
    let results: [SimilarResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct SimilarResult: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: SimilarOriginalLanguage
    let originalTitle, overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum SimilarOriginalLanguage: String, Codable {
    case de = "de"
    case en = "en"
    case fr = "fr"
    case ml = "ml"
    case ru = "ru"
    case it = "it"
    case cs = "cs"
    case ja = "ja"
}

