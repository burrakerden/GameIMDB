//
//  FavoriteViewController.swift
//  deneme2222
//
//  Created by Burak Erden on 19.01.2023.
//

import UIKit
import CoreData
import Kingfisher

class FavoriteViewController: UIViewController {
    
    var viewModel = ViewModel()
    let contextt = ViewModel().context
    
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var favCollecitonView: UICollectionView!
    
    //MARK: - Life Cycle
    
    override func viewDidAppear(_ animated: Bool) {
        fetchCoreData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    //MARK: - Fetch Data
    
    func fetchCoreData() {
        viewModel.fetchCoreData(favCollecitonView: favCollecitonView, emptyLabel: emptyLabel)
    }
    
    //MARK: - Config
    
    func setup() {
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
        favCollecitonView.delegate = self
        favCollecitonView.dataSource = self
        self.favCollecitonView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
    }
}

    //MARK: - Collection View

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.favCoreData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MainCollectionViewCell = favCollecitonView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as? MainCollectionViewCell else {return UICollectionViewCell()}
        if let game = viewModel.favCoreData?[indexPath.row] {
            cell.gameTitle.text = game.name
            cell.gameRating.text = String(format: "%.2f", game.rating)
            cell.gameDate.text = game.released
            cell.gameImage.kf.setImage(with: URL(string: game.backgroundImage ?? "" ))
            cell.index = indexPath
            cell.delegate = self
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        guard let idToPush = viewModel.favCoreData?[indexPath.row].gameId else {return}
        vc.gameId = Int(idToPush)
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Delete Button

extension FavoriteViewController: DataCollectionProtocol {

    func deleteData(index: Int) {
        let gameToRemove = self.viewModel.favCoreData![index]
        self.contextt.delete(gameToRemove)
        do {
            try self.contextt.save()
            print("deleting-success")
        } catch {
            print("error-Deleting data")
        }
        fetchCoreData()
    }
}
