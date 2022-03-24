//
//  NetworkManager.swift
//  OmdbMovieApp
//
//  Created by Selcuk on 19.03.2022.
//

import Foundation
import Alamofire

struct GetMovies{
    
    static let shared = GetMovies()
    // List the searched movies.
     func searchQuery(query: String, number: Int, completion: @escaping (_ data: MovieResult?,_ success: Bool ) -> Void){
        let url = "https://omdbapi.com/?apikey=b4343aa1&s=\(query)&page=\(number)"
    
                  AF.request(url).responseDecodable(of: MovieResult.self) { (response) in
                      guard let items = response.value else {
                          completion(nil, false)
                    
                          return
                      }
                      completion(items,true)
                  }
    }

    //Movie details by IMDB id
    func movieDetail(id:String,completion: @escaping (_ data: MoviesDetail?,_ success: Bool) -> Void){
        let url =  "https://www.omdbapi.com/?i=\(id)&apikey=b4343aa1"
        
        AF.request(url,method: .get).validate().responseDecodable(of: MoviesDetail.self){ response in
            guard let items = response.value else {
                completion(nil,false)
                return
            }
            completion(items,true)
        }
    }
}


