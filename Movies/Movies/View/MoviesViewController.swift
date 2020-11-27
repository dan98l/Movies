//
//  ShowMoviesViewController.swift
//  Movies
//
//  Created by Daniil G on 13.11.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import SideMenu
import UIKit
import Alamofire

class MoviesViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var table: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    var viewModel: MoviesViewModel!
    let searchBar = UISearchBar()
    var test: String = ""
    
    static func instantiate() -> MoviesViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as! MoviesViewController
        
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        setNavigationController()
        setupTableView()
        createSearchBar()
    }
    
    private func createSearchBar() {
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Enter your search here"
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }

    private func setNavigationController() {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = UIColor.white
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(didTapLeftBarButton))
    }
    
    @objc func didTapLeftBarButton() {
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        viewModel.didTapMenu()
    }
    
    func setupTableView() {
        viewModel.getPopularMovies(indexPage: viewModel.statusOfLoadMovie.page, completion: {
            self.table.delegate = self
            self.table.dataSource = self
            self.table.rowHeight = 245
            self.table.reloadData()
        })
    }
}

// MARK: - TableView DataSource
extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didTapMoviesCell(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetaillMovieCell
        cell.selectionStyle = .none
        
        cell.averageOfMovie = self.viewModel.getAverage(index: indexPath.row)
        cell.overviewOfMovie = self.viewModel.getOverview(index: indexPath.row)
        cell.titleOfMovie = self.viewModel.getTitle(index: indexPath.row)
        cell.posterPath1 = self.viewModel.getPosterPath(index: indexPath.row)
        
        viewModel.getImageOfMovie(index: indexPath.row) { image, posterPath in
            cell.posterPath2 = posterPath
            cell.imageOfMovie = image
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset
        
        if deltaOffset <= 0 {
            self.activityIndicator.startAnimating()
            loadMoreMovies()
        }
    }
    
    func loadMoreMovies() {
        if viewModel.statusOfLoadMovie.loading {
            viewModel.getPopularMovies(indexPage: viewModel.statusOfLoadMovie.page, completion: {
                self.activityIndicator.stopAnimating()
                self.table.reloadData()
            })
        }
    }
}

// MARK: - UISearchBarDelegate
extension MoviesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchMovies(titleMovies: searchBar.text!) {
             self.table.reloadData()
        }
    }
}
