//
//  ListTableViewCell.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 20/1/22.
//

import UIKit
import Kingfisher

struct ListTableCellViewModel {
    let imageUrl: URL?
    let text: String
}

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    
    @IBAction func favoritePressed(_ sender: Any) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(viewModel: ListTableCellViewModel) {
        nameLabel.text = viewModel.text
        catImage.kf.indicatorType = .activity
        catImage.kf.setImage(with: viewModel.imageUrl)
    }
}
