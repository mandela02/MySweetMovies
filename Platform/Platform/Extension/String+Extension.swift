//
//  String+Extension.swift
//  Platform
//
//  Created by Tri Bui Q. VN.Hanoi on 15/12/2022.
//

import Foundation

extension String {
    static let endpoint = "api.themoviedb.org"
    static let key = "4df263f48a4fe2621749627f5d001bf0"
    
    static let movieGenrePath = "/3/genre/movie/list"
    static let tvGenrePath = "/3/genre/tv/list"
    static let nowPlayingPath = "/3/movie/now_playing"
    static let upcommingPath = "/3/movie/upcoming"
    static let popularPath = "/3/movie/popular"
    static let topRatedPath = "/3/movie/top_rated"
    static let discoverMovie = "/3/discover/movie"
    
    static let movieDetailPath = "/3/movie/%@"
}
