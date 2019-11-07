//
//  PeopleListController.swift
//  CleanWeather
//
//  Created by Patryk Średziński on 07/11/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import UIKit

protocol PeopleListPresentable: UIViewController {
    func displayPeople(_ people: [PersonDisplayable])
    func presentAlert(title: String, body: String)
    func updateSpinner(state: Bool)
}

final class PeopleListController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
        
    private var dataSource = [PersonDisplayable]()
    
    private let interactor: PeopleListInteractor

    init(interactor: PeopleListInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.getPeople()
    }
    
}

extension PeopleListController: PeopleListPresentable {
    
    func displayPeople(_ people: [PersonDisplayable]) {
        dataSource = people
        tableView.reloadData()
    }
    
    func presentAlert(title: String, body: String) {
        let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func updateSpinner(state: Bool) {
        // TODO: Build proper spinner logic
        UIView.animate(withDuration: 0.3) {
            self.tableView.backgroundColor = state ? .orange : .white
        }
    }
}

extension PeopleListController: UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Build proper cells and dequeue them
        let cell = UITableViewCell()
        cell.backgroundColor = .clear
        cell.imageView?.image = UIImage(named: dataSource[indexPath.row].genderIconName)
        cell.textLabel?.text = dataSource[indexPath.row].name
        return cell
    }
}

extension PeopleListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let personId = dataSource[indexPath.row].id
        interactor.didSelectItem(personId: personId)
    }
    
}
