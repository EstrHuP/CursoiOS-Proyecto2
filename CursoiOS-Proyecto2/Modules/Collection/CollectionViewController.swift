//
//  CollectionViewController.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 19/1/22.
//

import UIKit

class CollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var fetchLandmarks: FetchLandmarksUseCase?
    var detailBuilder: DetailControllerBuilder?
    
    private var landmarks = [Landmark]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        fetchDataCollection()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
}

extension CollectionViewController {
    
    private var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 30, right: 10)
        
        //Calcular espacio de las celdas (en este caso se mostrarán 2)
        let width = (collectionView.frame.width / 2) //ancho
        let total = width - (layout.minimumInteritemSpacing / 2) //interitemSpacing
        let totalIzq = total - layout.sectionInset.left //izquierdo
        
        //layout.estimatedItemSize = CGSize(width: totalIzq, height: totalIzq)
        layout.itemSize = CGSize(width: totalIzq, height: totalIzq)
        
        return layout
    }
    
    private func fetchDataCollection() {
        fetchLandmarks?.fetchLandmarks({ result in
            switch result {
            case .success(let landmarks):
                self.landmarks = landmarks
            case .failure: break
            }
        })
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = landmarks[indexPath.row]
        guard let detail = detailBuilder?.build(viewModel: model.toDetailViewModel) else {
            return
        }
        navigationController?.pushViewController(detail, animated: true)
    }
}
extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return landmarks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else {
            fatalError()
        }
        
        let model = landmarks[indexPath.row]
        cell.configure(with: model.toCollectionCellViewModel)
        
        return cell
    }
}
