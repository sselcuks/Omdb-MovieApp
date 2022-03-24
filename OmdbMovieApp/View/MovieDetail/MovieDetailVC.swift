//
//  MovieDetail.swift
//  OmdbMovieApp
//
//  Created by Selcuk on 20.03.2022.
//

import Foundation
import UIKit

class MovieDetailVC: UIViewController{
    
    @IBOutlet weak var detailPoster: UIImageView!
    @IBOutlet weak var movieDuration: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieLang: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var moviePlot: UILabel!
    @IBOutlet weak var movieDirector: UILabel!
    @IBOutlet weak var movieCountry: UILabel!
    var myDetailView: MoviesDetail?
    
    let error = Constants.FetchError.dataError
    let placeholderImg = Constants.FetchError.placeholderImage
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
    }
    
    func setUI(){
        movieDuration?.text = myDetailView?.runtime
        
        detailPoster?.setImage(imageUrl: myDetailView?.poster?.replacingOccurrences(of: "N/A", with: placeholderImg) ?? "error")
        movieYear?.text = "Year  \(myDetailView?.year ?? "error")"
        movieLang?.text = myDetailView?.genre
        moviePlot?.text = myDetailView?.plot
        movieGenre?.text = "Genre: \(myDetailView?.genre ?? error)"
        movieDirector?.text = "Director: \(myDetailView?.director ?? error)"
        movieCountry?.text = myDetailView?.country ?? error
    }
    
}
