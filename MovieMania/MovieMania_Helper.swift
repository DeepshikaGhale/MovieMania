//
//  MovieMania_Helper.swift
//  MovieMania
//
//  Created by Deepshika Ghale on 2023-08-14.
//

import Foundation

class MovieMania_Helper {
    static let headers = [
        "X-RapidAPI-Key": "2ef80a3892mshe92c82619dc66b0p153078jsn9f607eee0778",
        "X-RapidAPI-Host": "netflix54.p.rapidapi.com"
    ]

    public static func fetch() async throws -> Data {
        let url = URL(string: "https://netflix54.p.rapidapi.com/search/?query=stranger&offset=0&limit_titles=50&limit_suggestions=20&lang=en")!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
    
    public static func fetchMovieData() async throws -> MovieData {
        let data = try await fetch()
        
        let decoder = JSONDecoder()
        let movieData = try decoder.decode(MovieData.self, from: data)
        return movieData
    }
}
