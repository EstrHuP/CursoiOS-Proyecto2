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

protocol ListTableViewDelegate: AnyObject {
    func didPressInFavorite(cell: ListTableViewCell)
}

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    
    weak var delegate: ListTableViewDelegate?
    
    var isFavorite = false {
        didSet {
            isFavorite ? favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal) : favButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    @IBAction func favoritePressed(_ sender: Any) {
        delegate?.didPressInFavorite(cell: self)
    }
    
    override func prepareForReuse() {
        
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
