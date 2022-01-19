//
//  DetailViewController.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 19/1/22.
//

import UIKit

struct DetailViewModel {
    let name: String
    let image: UIImage?
}
class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    
    var viewModel: DetailViewModel?
    
    static func createFromXib() -> DetailViewController {
        return DetailViewController.init(nibName: "DetailViewController", bundle: .main)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(with: viewModel)
    }
    
    func configure(with viewModel: DetailViewModel?) {
        guard let model = viewModel else { return }
        detailImage.image = model.image
        nameLabel.text = model.name
    }
}
