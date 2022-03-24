//
//  MovieModel.swift
//  OmdbMovieApp
//
//  Created by Selcuk on 19.03.2022.
//

import Foundation


struct MovieResult: Codable{
    var totalResults: String
    var Response: String
    var Search:[Movie]
   
}

struct Movie: Codable{
    let title:String
    let year:String
    let imdbID:String
    let _Type:String
    let poster:String
    
    private enum CodingKeys: String,CodingKey{
        case title = "Title", year = "Year",imdbID, _Type = "Type",poster = "Poster"
    }
    
}
