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
    var viewModel: MoviesViewModel?
    let searchBar = UISearchBar()
    
    static func instantiate() -> MoviesViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as! MoviesViewController
        
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        setNavigationController()
        setupTableView()
        setSearchBar()
    }
    
    private func setSearchBar() {
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
        if let model = viewModel {
            model.didTapMenu()
        }
    }
    
    func setupTableView() {
        if let model = viewModel {
            model.getPopularMovies(indexPage: model.movieLoadStatus.page, completion: {
                self.table.delegate = self
                self.table.dataSource = self
                self.table.rowHeight = 245
                self.table.reloadData()
            })
        }
    }
}

// MARK: - TableView DataSource
extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewModel = viewModel {
            viewModel.didTapMoviesCell(index: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModel = viewModel {
            return viewModel.numberOfRowsInSection(section: section)
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetaillMovieCell
        cell.selectionStyle = .none
        
        if let viewModel = viewModel {
            let cellViewModel = viewModel.cellViewModel(index: indexPath.row)
            
            cell.movieTitle = cellViewModel.movieTitle()
            cell.movieAverage = cellViewModel.movieAverage()
            cell.movieOverview = cellViewModel.movieOverview()
            cellViewModel.getImageData(completion: { data in
                cell.movieData = data
            })
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
        if let viewModel = viewModel {
          if viewModel.movieLoadStatus.loading {
               viewModel.getPopularMovies(indexPage: viewModel.movieLoadStatus.page, completion: {
                   self.activityIndicator.stopAnimating()
                   self.table.reloadData()
               })
           }
       }
    }
}

// MARK: - UISearchBarDelegate
extension MoviesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let viewModel = viewModel {
            viewModel.searchMovies(titleMovies: searchBar.text!) {
                 self.table.reloadData()
            }
        }
    }
}
