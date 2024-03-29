//
//  ViewController.swift
//  Intervk
//
//  Created by Andrei Kovryzhenko on 28.03.2024.
//

import UIKit

class ViewController: UIViewController {
    
    private var tableView = UITableView()
    private var servicesData = [Service]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        loadContent()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ServiceCell.self, forCellReuseIdentifier: "Cell")
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        tableView.rowHeight = view.frame.height / 11
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupBackground() {
        navigationItem.title = "Сервисы"
        
        let textAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)
        ]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        view.backgroundColor = .black.withAlphaComponent(0.96)
    }
    
    private func loadContent() {
        NetworkManager.shared.getServices { [weak self] value in
            guard let self else { return }
            self.servicesData = value
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        servicesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ServiceCell
        cell.configure(with: servicesData[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let url = URL(string: servicesData[indexPath.row].link) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}

#Preview{
    ViewController()
}
