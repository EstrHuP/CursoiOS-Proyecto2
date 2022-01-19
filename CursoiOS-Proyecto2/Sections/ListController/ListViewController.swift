//
//  ListViewController.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 19/1/22.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var fetchLandmarks: FetchLandmarksUseCase?
    
    static func createFromStoryboard() -> ListViewController {
        return UIStoryboard(name: "ListViewController", bundle: .main).instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        fetchData()
    }
    
    //Setear los landmarks
    private var landmarks = [Landmark]() {
        //setear cada vez que se ejecute esta var
        didSet {
            //recargar datos
            tableView.reloadData()
        }
    }
    
    private func fetchData() {
        fetchLandmarks?.fetchLandmarks({ result in
            switch result {
            case .success(let landmarks):
                self.landmarks = landmarks
            case .failure: break
            }
        })
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return landmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        let landmarks = landmarks[indexPath.row]
        
        cell.textLabel?.text = landmarks.name
        cell.detailTextLabel?.text = landmarks.park
        return cell
    }
}
