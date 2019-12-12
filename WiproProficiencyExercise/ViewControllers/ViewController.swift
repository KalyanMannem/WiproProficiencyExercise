//
//  ViewController.swift
//  WiproProficiencyExercise
//
//  Created by Kalyan Mannem on 12/12/19.
//  Copyright © 2019 CompIndia. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    let tableView = UITableView()
    private var results: [Row] = []
    private let canadaViewModel = CanadaViewModel()
    
    override func loadView()
    {
        super.loadView()
        setUpTableView()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        updateTablview()
        getServiceData()
    }
    
    func setUpTableView()
    {
        let safeGuide = self.view.safeAreaLayoutGuide
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: safeGuide.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: safeGuide.rightAnchor).isActive = true
        tableView.register(RowTableViewCell.self, forCellReuseIdentifier: "ItemCell")
    }
    
    func updateTablview()
    {
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        if #available(iOS 13.0, *)
        {
            self.view.backgroundColor = .systemBackground
            self.tableView.backgroundColor = .systemBackground
        }
        else
        {
            // Fallback on earlier versions
            self.view.backgroundColor = .white
        }
    }
    
    func getServiceData()
    {
        self.callIngAPI(url: AppConstants.SERVICE_URL)
    }
    
    func callIngAPI(url: String)
    {
        canadaViewModel.getCanadaDetails(url: url) {[weak self](result) in
            if let result = try? result.get()
            {
                DispatchQueue.main.async {
                    self?.results = result.rows.filter({$0.imageHref != nil || $0.title != nil || $0.rowDescription != nil  })
                    self?.title = result.title
                    self?.tableView.reloadData()
                }
            }
        }
    }

}

extension ViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! RowTableViewCell
        cell.item = results[indexPath.row]
        return cell
    }
}

