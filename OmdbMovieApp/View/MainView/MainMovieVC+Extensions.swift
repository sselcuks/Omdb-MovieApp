//
//  MainMovieVC+Extensions.swift
//  OmdbMovieApp
//
//  Created by Selcuk on 23.03.2022.
//

import Foundation
import UIKit

extension MainMovieVC{
    
    func setUI(){
        title = "Omdb Movie"
        searchText.placeholder = "Type here to search movies.."
        searchText.layer.borderColor = UIColor.blue.cgColor
        searchText.layer.borderWidth = 1.5
        movieList.separatorStyle = UITableViewCell.SeparatorStyle.none
        totalMovies.alpha = 0
    }
}

// Textfield
extension MainMovieVC{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        SearchList.removeAll()
        movieSearch()
        return true
    }
    
    // -MARK: Movie Search
    func movieSearch(){
        
        searchText.resignFirstResponder()
        // check textfield text.
        guard let search = searchText.text, !search.isEmpty else{
            return
        }
        
        //check for space.
        let query = search.replacingOccurrences(of: " ", with: "%20")
        
        presenter.searchMovie(query: query, number: number) { success in
            if success {
                DispatchQueue.main.async {
                    self.movieList.reloadData()
                    self.totalMovies.alpha = 1
                    self.totalMovies.text = "Total Movie : \(self.searchResult!.totalResults)"
                }
            }
            else{
                self.displayAlert(title: "Your search \(self.searchText.text!) not found." , message: "Check your network and spelling !" )
            }
        }
    }
}

extension MainMovieVC: UITextFieldDelegate{}
extension MainMovieVC: AlertDisplaying{}
