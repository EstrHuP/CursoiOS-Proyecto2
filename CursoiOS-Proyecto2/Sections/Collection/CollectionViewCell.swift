//
//  CollectionViewCell.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 20/1/22.
//

import UIKit

struct CollectionViewModel {
    let name: String
    let image: UIImage?
}

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var nameLabelCell: UILabel!
    
    var viewModel: CollectionViewModel?

    func configure(with viewModel: CollectionViewModel?) {
        guard let model = viewModel else { return }
        imageViewCell.image = model.image
        nameLabelCell.text = model.name
        cardDesign()
    }
    
    private func cardDesign() {
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true //
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }
}
