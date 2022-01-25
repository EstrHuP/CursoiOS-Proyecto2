//
//  ListViewController.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 19/1/22.
//

import UIKit
import Kingfisher

class ListViewController: UIViewController, ListViewContract {

    //VIPER
    var presenter: ListPresenterContract?
    
    @IBOutlet weak var tableView: UITableView!
    
    
    static func createFromStoryboard() -> ListViewController {
        return UIStoryboard(name: "ListViewController", bundle: .main).instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        presenter?.viewDidLoad()
    }
    
    private var favorites = [String]()
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setFavorite(_ favorite: Bool, at indexPath: IndexPath) {
        DispatchQueue.main.async {
            guard let cell = self.tableView.cellForRow(at: indexPath) as? ListTableViewCell else { return }
            cell.isFavorite = favorite
        }
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectItem(at: indexPath)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numItems ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = presenter?.cellViewModel(at: indexPath), let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell else {
            fatalError()
        }
        
        cell.delegate = self
        cell.isFavorite = presenter?.isFavorite(at: indexPath) ?? false
        cell.configure(viewModel: viewModel)
        
        return cell
    }
}

extension ListViewController: ListTableViewDelegate {
    func didPressInFavorite(cell: ListTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        presenter?.didSelectFavorite(at: indexPath)
    }
}
