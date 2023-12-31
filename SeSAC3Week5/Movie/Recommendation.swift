//
//  Recommendation.swift
//  SeSAC3Week5
//
//  Created by 이승현 on 2023/08/17.
//

//import Foundation
//
//// MARK: - Welcome
//struct Recommendation: Codable {
//    let page: Int
//    let results: [RecommendationResult]
//    let totalPages, totalResults: Int
//
//    enum CodingKeys: String, CodingKey {
//        case page, results
//        case totalPages = "total_pages"
//        case totalResults = "total_results"
//    }
//}
//
//// MARK: - Result
//struct RecommendationResult: Codable {
//    let adult: Bool
//    let backdropPath: String?
//    let id: Int
//    let title: String
//    let originalLanguage: OriginalLanguage?
//    let originalTitle, overview, posterPath: String?
//    let mediaType: MediaType
//    let genreIDS: [Int]
//    let popularity: Double
//    let releaseDate: String
//    let video: Bool
//    let voteAverage: Double
//    let voteCount: Int
//
//    enum CodingKeys: String, CodingKey {
//        case adult
//        case backdropPath = "backdrop_path"
//        case id, title
//        case originalLanguage = "original_language"
//        case originalTitle = "original_title"
//        case overview
//        case posterPath = "poster_path"
//        case mediaType = "media_type"
//        case genreIDS = "genre_ids"
//        case popularity
//        case releaseDate = "release_date"
//        case video
//        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
//    }
//}
//
//enum MediaType: String, Codable {
//    case movie = "movie"
//}
//
//enum OriginalLanguage: String, Codable {
//    case en = "en"
//    case ko = "ko"
//    case zh = "zh"
//    case ru = "ru"
//    case it = "it"
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        let rawValue = try container.decode(String.self)
//
//        switch rawValue {
//        case "en", "ko", "zh":
//            self = OriginalLanguage(rawValue: rawValue)!
//        default:
//            self = .en // or any other default value
//        }
//    }
//}


import Foundation

// MARK: - Welcome
struct Recommendation: Codable {
    let page: Int
    let results: [RecommendationResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct RecommendationResult: Codable {
    let adult: Bool
    let backdropPath: String?
    let id: Int
    let title: String
    let originalLanguage: String
    let originalTitle, overview: String
    let posterPath: String?
    let mediaType: MediaType
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case ru = "ru"
}


