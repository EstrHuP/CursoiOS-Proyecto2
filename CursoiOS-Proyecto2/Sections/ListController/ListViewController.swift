//
//  ListViewController.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 19/1/22.
//

import UIKit
import Kingfisher

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var fetchCats: FetchCatsUseCase?
    var detailBuilder: DetailControllerBuilder?
    
    static func createFromStoryboard() -> ListViewController {
        return UIStoryboard(name: "ListViewController", bundle: .main).instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchData()
    }
    
    private var favorites = [String]()
    
    private var cats = [Cat]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func fetchData() {
        fetchCats?.fetchCats(completion: { cats in
            self.cats = cats
        })
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let model = cats[indexPath.row]
//        guard let detail = detailBuilder?.build(viewModel: model.toDetailViewModel) else {
//            return
//        }
//        navigationController?.pushViewController(detail, animated: true)
        
        //MARK: Navigation without builder
//        let landmark = landmarks[indexPath.row]
//        let viewController = DetailControllerBuilder().build(viewModel: landmark.toDetailViewModel)
//        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        let cat = cats[indexPath.row]
        
        cell.delegate = self
        cell.isFavorite = favorites.contains(cat.id)
        cell.configure(viewModel: cat.toListCellViewModel)
        
        return cell
    }
}

extension ListViewController: ListTableViewDelegate {
    func didPressInFavorite(cell: ListTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        cell.isFavorite = !cell.isFavorite
        
        let cat = cats[indexPath.row]
        
        if cell.isFavorite {
            favorites.append(cat.id)
        } else if let index = favorites.firstIndex(of: cat.id){
            favorites.remove(at: index)
        }
    }
}
