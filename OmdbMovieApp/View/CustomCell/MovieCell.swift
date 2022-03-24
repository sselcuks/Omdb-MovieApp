//
//  MovieCell.swift
//  OmdbMovieApp
//
//  Created by Selcuk on 19.03.2022.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    // Placholder image for not available poster.
    let placeholderImg = Constants.FetchError.placeholderImage
    
    @IBOutlet weak var cellView: UIView!
    
    var showMovie: Movie?{
        didSet{
            movieTitle.text = showMovie?.title
            movieYear.text = showMovie?.year
            moviePoster.setImage(imageUrl: showMovie?.poster.replacingOccurrences(of: "N/A", with: placeholderImg) ?? "error")
            
            cellView.layer.shadowColor = UIColor.lightGray.cgColor
            cellView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            cellView.layer.shadowOpacity = 1.0
            
            cellView.layer.masksToBounds = false
            cellView.layer.cornerRadius = 12
            
        }
    }
}
