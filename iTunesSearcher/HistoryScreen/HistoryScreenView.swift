//
//  HistoryScreenView.swift
//  iTunesHistoryer
//
//  Created by Captain Kidd on 01.12.2021.
//

import Foundation
import UIKit
import RealmSwift

protocol HistoryScreenViewControllerProtocol {
    var presenter: HistoryScreenPresenterProtocol? { get set }
}

class TableViewCell: UITableViewCell { }

class HistoryScreenViewController: UIViewController,
                                   HistoryScreenViewControllerProtocol,
                                   UITableViewDelegate,
                                   UITableViewDataSource{

    var presenter: HistoryScreenPresenterProtocol?
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(TableViewCell.self,
                       forCellReuseIdentifier: "TableViewCell")
        return table
    }()
    var elements: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        elements = []
        let realm = try! Realm()

        let results = realm.objects(History.self)
        for result in results {
            elements.append(result.searching!)
        }
        tableView.reloadData()
    }
    
    private func setTableView() {
        tableView.frame  = view.bounds
        tableView.backgroundColor = UIColor(red: 0.9,
                                            green: 0.9,
                                            blue: 0.9,
                                            alpha: 1.0)
        self.tableView.rowHeight = 70
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.textLabel?.text = elements[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SearchFromHistory.sharedData.search = elements[indexPath.row]
        presenter?.searchFromHistory()
    }
}
