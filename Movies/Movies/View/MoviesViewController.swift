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
    @IBOutlet weak var collectionMovies: UICollectionView!
    
    // MARK: - Properties
    var viewModel: MoviesViewModel?
    let searchBar = UISearchBar()
    
    var moviesCollection = [Movies]()
    var imagesDataCollection = [Data]()
    
    static func instantiate() -> MoviesViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as! MoviesViewController
        
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        setupNavigationControlleStyler()
        setupSearchBar()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionMovies.scrollToItem(at: IndexPath(item: 250, section: 0), at: .left, animated: false)
    }
    
    private func setupSearchBar() {
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Enter your search here"
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }

    private func setupNavigationControlleStyler() {
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
    
    func setup() {
        if let model = viewModel {
            model.getPopularMovies(indexPage: model.movieLoadStatus.page, completion: {
                self.setupTableView()
                self.setupCollectionView()
            })
        }
    }
    
    func setupTableView() {
            self.table.delegate = self
            self.table.dataSource = self
            self.table.rowHeight = 245
            self.table.reloadData()
    }
    
    func setupCollectionView() {
        self.collectionMovies.reloadData()
        if let model = viewModel {
            model.movieCollection(completion: { movies, dataImage in
                if let data = dataImage, let movies = movies {
                    self.moviesCollection = movies
                    self.imagesDataCollection = data
                    DispatchQueue.main.async {
                        self.collectionMovies.delegate = self
                        self.collectionMovies.dataSource = self
                    }
                }
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
            cell.movieOverview = cellViewModel.movieOverview()
            cell.fillArea = cellViewModel.movieAverage()
            cell.beams = cellViewModel.beamsStars
            
            cellViewModel.getImageData(completion: { data in
                    cell.movieData = data
            })
        }
        
        return cell
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let currentOffset = scrollView.contentOffset.y
//        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
//        let deltaOffset = maximumOffset - currentOffset
//
//        if deltaOffset <= 0 {
//            self.activityIndicator.startAnimating()
//            if let viewModel = viewModel {
//                viewModel.endScroll(completion: {
//                    self.table.reloadData()
//                })
//            }
//        }
//    }
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

// MARK: - UICollectionView
extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 500
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewModel = viewModel {
            print(indexPath.row)
            print(moviesCollection.count)
            print(indexPath.row % moviesCollection.count)
            viewModel.didTapMoviesCell(index: indexPath.row % moviesCollection.count)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! MoviesCollectionCell
        
        if let title = moviesCollection[indexPath.row % moviesCollection.count].title,
            let overview = moviesCollection[indexPath.row % moviesCollection.count].overview {
            
            cell.movieTitle = title
            cell.movieOverview = overview
            
        }
        
        cell.imageData = imagesDataCollection[indexPath.row % imagesDataCollection.count]
        cell.fillArea = moviesCollection[indexPath.row % moviesCollection.count].voteAverage

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400, height: 245)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage: Int = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        
        if currentPage >= 350 {
            collectionMovies.scrollToItem(at: [0, 250], at: .right, animated: false)
        } else if currentPage <= 150 {
            collectionMovies.scrollToItem(at: [0, 250], at: .right, animated: false)
        }
    }
}
