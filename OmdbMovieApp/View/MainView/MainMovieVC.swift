//
//  ViewController.swift
//  OmdbMovieApp
//
//  Created by Selcuk on 17.03.2022.
//

import UIKit

class MainMovieVC: UIViewController{
    
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var movieList: UITableView!
    @IBOutlet weak var totalMovies: UILabel!
    var number = 1
    var hasMoreMovie = true
    
    var presenter =  MovieListPresenter()
    var searchResult: MovieResult?
    var selectedMovieDetail: MoviesDetail?
    
    var SearchList: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setUI()
    }

    func configure(){
        presenter.delegate = self
        movieList.delegate = self
        movieList.dataSource = self
        movieSearch()
        searchText.delegate = self
    }
    
}

extension MainMovieVC:MovieDelegate{
    // Navigate to the detail page.
    func detailMovie(movieDetails: MoviesDetail?) {
        // Pass selected data to the detail view controller.
        self.selectedMovieDetail = movieDetails
        
        let storyboard = UIStoryboard(name: "MovieDetailVC", bundle: nil)
        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailVC") as? MovieDetailVC else { return }
        detailVC.myDetailView = movieDetails
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // Load more movies.
    func searchMovie(searches: MovieResult?) {
        
        self.searchResult = searches
        self.SearchList += searches!.Search
        guard self.hasMoreMovie else {return}
        self.number += 1
        
    }
}

extension MainMovieVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return SearchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = movieList.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else{ return UITableViewCell()}
        cell.showMovie = SearchList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Retrive selected movieID for detail view values.
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.detailMovie(id: SearchList[indexPath.row].imdbID) { success in }
        
    }
    
    // Load more movies from API.
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            movieSearch()
        }
    }
}

