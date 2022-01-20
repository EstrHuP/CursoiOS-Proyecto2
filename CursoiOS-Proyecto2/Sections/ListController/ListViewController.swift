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
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        let cat = cats[indexPath.row]
        
        cell.textLabel?.text = cat.tagsText
        cell.imageView?.kf.setImage(with: cat.imageUrl)
        
        //Forma "sucia" de pintar imagenes desde internet
//        if let url = cat.imageUrl, let data = try? Data(contentsOf: url) {
//            cell.imageView?.image = UIImage(data: data)
//        }
        
        return cell
    }
}
