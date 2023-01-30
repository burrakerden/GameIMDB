//
//  ViewModel.swift
//  GameIMDB
//
//  Created by Burak Erden on 27.01.2023.
//

import Foundation
import UIKit
import Alamofire
import CoreData

class ViewModel {
    
    
    
    var sliderGames = [Result]()
    var games = [Result]()
    var searchData = [Result]()
    
    var detailData: DetailApi?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var favCoreData: [GameData]?
    
//MARK: - MAIN VC
    
    func getMovieData(navigationItem: UINavigationItem, navigationController: UINavigationController, myCollectionView: UICollectionView, sliderCollectionView: UICollectionView) {
        Service().getMovie { result in
            guard let result1 = result?.results else {return}
            self.games = result1
            self.searchData = result1
            for _ in 0...2 {
                self.sliderGames.append(self.games[0])
                self.games.remove(at: 0)
            }
            self.setupUI(navigationItem: navigationItem, navigationController: navigationController, myCollectionView: myCollectionView, sliderCollectionView: sliderCollectionView)
        } onError: { error in
            print(error)
        }
    }
    
    func setupUI(navigationItem: UINavigationItem, navigationController: UINavigationController, myCollectionView: UICollectionView, sliderCollectionView: UICollectionView) {

        navigationItem.backButtonTitle = " "
        navigationController.navigationBar.tintColor = .black
        myCollectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
        sliderCollectionView.register(UINib(nibName: "SliderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SliderCollectionViewCell")
        myCollectionView.reloadData()
        sliderCollectionView.reloadData()
    }
    
    //MARK: - DETAIL VC
    
    func getDetailData(id: Int, detailName: UILabel, detailDate: UILabel, detailRate: UILabel, detailOverview: UILabel, detailImage: UIImageView) {
        DetailService().getMovieDetail(text: id) { result in
            guard let data = result else {return}
            self.detailData = data
            self.setupInterface(detailName: detailName, detailDate: detailDate, detailRate: detailRate, detailOverview: detailOverview, detailImage: detailImage)
        } onError: { error in
            print(error)
        }
    }
    
    func setupInterface(detailName: UILabel, detailDate: UILabel, detailRate: UILabel,  detailOverview: UILabel, detailImage: UIImageView) {
        detailName.text = detailData?.name
        detailDate.text = detailData?.released
        detailRate.text = "Metacritic Rate: " + String((detailData?.metacritic)!)
        detailOverview.text = detailData?.descriptionRaw
        detailImage.kf.setImage(with: URL(string: detailData?.backgroundImageAdditional ?? ""))
    }
    
    //MARK: - FAVORITE VC
    
    func fetchCoreData(favCollecitonView: UICollectionView, emptyLabel: UILabel) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameData")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            self.favCoreData = try context.fetch(GameData.fetchRequest())
            favCollecitonView.reloadData()
            if favCoreData!.count == 0 {
                emptyLabel.isHidden = false
            } else {
                emptyLabel.isHidden = true
            }

        } catch {
        }

    }
    
}

