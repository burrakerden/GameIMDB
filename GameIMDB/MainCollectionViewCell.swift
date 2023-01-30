//
//  MainCollectionViewCell.swift
//  deneme2222
//
//  Created by Burak Erden on 19.01.2023.
//

import UIKit

protocol DataCollectionProtocol {
    func deleteData(index: Int)
}

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gameDate: UILabel!
    @IBOutlet weak var gameRating: UILabel!
    
    var delegate: DataCollectionProtocol?
    var index: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        delegate?.deleteData(index: index!.row)
    }
}
