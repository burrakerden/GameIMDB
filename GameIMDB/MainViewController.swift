//
//  MainViewController.swift
//  deneme2222
//
//  Created by Burak Erden on 19.01.2023.
//

import UIKit
import Kingfisher
import Alamofire

class MainViewController: UIViewController {

    var searchResultData = [Result]()
    
    var viewModel = ViewModel()
    
    @IBOutlet weak var notFoundLabel: UILabel!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    //MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupUI()
    }
    
    //MARK: - Fetch Data
    
    func getData() {
        viewModel.getMovieData(navigationItem: navigationItem, navigationController: navigationController!, myCollectionView: myCollectionView, sliderCollectionView: sliderCollectionView)
    }
    //MARK: - Config
    
    func setupUI() {
        searchBar.delegate = self
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        sliderCollectionView.dataSource = self
        sliderCollectionView.delegate = self
    }
}

    //MARK: - Collection Views

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == myCollectionView){
            if !sliderCollectionView.isHidden {
                return viewModel.games.count
            } else {
                return searchResultData.count
            }
        }
        return viewModel.sliderGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == myCollectionView) {
            guard let cell: MainCollectionViewCell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as? MainCollectionViewCell else {return UICollectionViewCell()}
            if !sliderCollectionView.isHidden {
                let game = viewModel.games[indexPath.row]
                cell.deleteButton.isHidden = true
                cell.gameTitle.text = game.name
                cell.gameRating.text = String(format: "%.2f", game.rating ?? "?")
                cell.gameDate.text = game.released
                cell.gameImage.kf.setImage(with: URL(string: game.backgroundImage ?? ""))
                return cell
            } else {
                let game = searchResultData[indexPath.row]
                cell.gameTitle.text = game.name
                cell.gameRating.text = String(format: "%.2f", game.rating ?? "?")
                cell.gameDate.text = game.released
                cell.gameImage.kf.setImage(with: URL(string: game.backgroundImage ?? ""))
                return cell
            }
        }
        guard let cell: SliderCollectionViewCell = sliderCollectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath) as? SliderCollectionViewCell else {return UICollectionViewCell()}
        let SliderGame = viewModel.sliderGames[indexPath.row]
        cell.sliderTitle.text = "    " + (SliderGame.name ?? "")
        cell.sliderImage.kf.setImage(with: URL(string: SliderGame.backgroundImage ?? ""))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == myCollectionView) {
            if !sliderCollectionView.isHidden {
                let vc1 = DetailViewController()
                guard let id1 = (viewModel.games[indexPath.row].id) else {return}
                vc1.gameId = id1
                navigationController?.pushViewController(vc1, animated: true)
                
            } else {
                let vc1 = DetailViewController()
                guard let id1 = (searchResultData[indexPath.row].id) else {return}
                vc1.gameId = id1
                navigationController?.pushViewController(vc1, animated: true)
            }
        } else {
            let vc = DetailViewController()
            guard let id1 = (viewModel.sliderGames[indexPath.row].id) else {return}
            vc.gameId = id1
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

    // MARK: - Search Bar

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count >= 3 {
            searchResultData.removeAll()
            searchResultData = viewModel.searchData.filter { $0.name?.range(of: searchText, options: .caseInsensitive) != nil }
                if searchResultData.isEmpty {
                    notFoundLabel.isHidden = false
                }
            sliderCollectionView.isHidden = true
            pageController.isHidden = true
            myCollectionView.reloadData()
        } else {
            notFoundLabel.isHidden = true
            sliderCollectionView.isHidden = false
            pageController.isHidden = false
            myCollectionView.reloadData()
        }
    }
}

    //MARK: - Page Control

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageController.currentPage = Int(pageNumber)
    }
}
