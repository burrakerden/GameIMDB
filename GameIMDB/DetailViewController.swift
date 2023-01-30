//
//  DetailViewController.swift
//  deneme2222
//
//  Created by Burak Erden on 19.01.2023.
//

import UIKit
import Kingfisher
import CoreData

class DetailViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var checkNameFromCoreData: [GameData]?

    var gameId: Int?
    var viewModel = ViewModel()
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var detailDate: UILabel!
    @IBOutlet weak var detailRate: UILabel!
    @IBOutlet weak var detailOverview: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        guard let id = gameId else {return}
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameData")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            self.checkNameFromCoreData = try context.fetch(GameData.fetchRequest())
            guard let gameData = checkNameFromCoreData else {return}
            let sameName = gameData.filter{$0.name == viewModel.detailData?.name}
            if sameName.isEmpty {
                let saveData = NSEntityDescription.insertNewObject(forEntityName: "GameData", into: context)
                
                saveData.setValue(viewModel.detailData?.name, forKey: "name")
                saveData.setValue(viewModel.detailData?.rating, forKey: "rating")
                saveData.setValue(viewModel.detailData?.released, forKey: "released")
                saveData.setValue(viewModel.detailData?.backgroundImage, forKey: "backgroundImage")
                saveData.setValue(Double(id), forKey: "gameId")

                do {
                    try context.save()
                    print("succes")
                } catch {
                    print("error")
                }
            } else {
                print("has been pushed before")
            }
        } catch {
            
        }
    }
    
    //MARK: - Fetch Detail Data
    
    func getDetailData(id: Int) {
        viewModel.getDetailData(id: id, detailName: detailName, detailDate: detailDate, detailRate: detailRate, detailOverview: detailOverview, detailImage: detailImage)
    }
    
    //MARK: - Config
    
    func setupUI() {
        navigationController?.isNavigationBarHidden = false
        guard let id = gameId else {return}
        getDetailData(id: id)
    }
    
    func setupInterface() {
        detailName.text = viewModel.detailData?.name
        detailDate.text = viewModel.detailData?.released
        detailRate.text = "Metacritic Rate: " + String((viewModel.detailData?.metacritic)!)
        detailOverview.text = viewModel.detailData?.descriptionRaw
        detailImage.kf.setImage(with: URL(string: viewModel.detailData?.backgroundImageAdditional ?? ""))
    }
}
