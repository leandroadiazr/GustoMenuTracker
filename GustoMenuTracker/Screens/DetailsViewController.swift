//
//  DetailsViewController.swift
//  GustoMenuTracker
//
//  Created by LeandroDiaz on 12/19/21.
//

import UIKit
import Anchorage

class DetailsViewController: UIViewController {
    
    var tableView: UITableView?
    var closeButton = CustomButton(backgroundColor: .clear, title: "", backgroundImage: UIImage(systemName: "xmark"))
    var generics = [Menu]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureViews()
    }
    
    private func configureViews() {
        view.addSubview(closeButton)
        closeButton.topAnchor == view.topAnchor + 20
        closeButton.trailingAnchor == view.trailingAnchor - 20
        closeButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView?.frame = view.bounds
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.backgroundColor = CustomColors.CustomBeigeColor
        guard let tableView = tableView else { return}
        view.addSubview(tableView)
        registerCells()
    }
    private func registerCells() {
        tableView?.register(DetailsCell.self, forCellReuseIdentifier: DetailsCell.reuseID)
    }
    
    @objc func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return generics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailsCell.reuseID, for: indexPath) as? DetailsCell
        let item = generics[indexPath.row]
        cell?.configureCell(with: item)
        return cell ?? UITableViewCell()
    }
}
