//
//  CartViewController.swift
//  GustoMenuTracker
//
//  Created by LeandroDiaz on 12/19/21.
//

import UIKit


class CartViewController: UIViewController, MenuViewControllerDelegate {
    func notify(item: Menu) {
        self.generics.append(item)
    }
    
    var viewModel: ContentViewModel? {
        didSet {
            guard let items = viewModel?.cartItems else { return }
            self.generics.append(contentsOf: items)
        }
    }
    
    var tableView: UITableView?
    var generics = [Menu]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    private func loadData() {
        if self.generics.isEmpty {
            PersistenceManager.retreiveItems { result in
                switch result {
                case .success(let items):
                    for item in items {
                        if self.generics.contains(item) {
                            return
                        }
                    }
                    self.viewModel?.cartItems?.append(contentsOf: items)
                    self.generics.append(contentsOf: items)
                    self.tableView?.reloadData()
                case .failure(let error):
                    print(error.rawValue)
                }
            }
        }
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView?.frame = view.bounds
        tableView?.register(CartTableViewCell.self, forCellReuseIdentifier: CartTableViewCell.reuseID)
        tableView?.delegate = self
        tableView?.dataSource = self
        guard let tableView = tableView else { return}
        view.addSubview(tableView)
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return generics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.reuseID, for: indexPath) as? CartTableViewCell
        let item = generics[indexPath.row]
        cell?.configureCell(with: item)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let item = generics[indexPath.row]
        self.generics.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        
        PersistenceManager.updateWith(menuItem: item, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else { return }
            DispatchQueue.main.async {
                self.customAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
}


