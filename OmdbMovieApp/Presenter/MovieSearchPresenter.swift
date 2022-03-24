//
//  MovieSearchPresenter.swift
//  OmdbMovieApp
//
//  Created by Selcuk on 19.03.2022.
//

import Foundation

protocol MovieDelegate: AnyObject{
    func searchMovie(searches: MovieResult?)
    func detailMovie(movieDetails: MoviesDetail?)
}

final class MovieListPresenter{
    weak var delegate: MovieDelegate?
    
    var movieList: MovieResult?

    func searchMovie(query:String,number: Int, completion: @escaping (_ success:Bool) -> Void){
        GetMovies.shared.searchQuery(query: String(query),number: Int(number)){ [weak self] result,
            success in
            if success{
                self?.delegate?.searchMovie(searches: result)
                completion(true)
            }
            else{
                completion(false)
            }
        }
    }
    func detailMovie(id: String, completion: @escaping (_ success: Bool) -> Void){
        GetMovies.shared.movieDetail(id: String(id)){ [weak self] result, success in
            if success{
                self?.delegate?.detailMovie(movieDetails: result)
            }
            else{
                completion(false)
            }
        }
    }
}

