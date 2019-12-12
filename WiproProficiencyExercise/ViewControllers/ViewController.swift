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
        tableView.dataSource = self
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func getServiceData()
    {
        self.callIngAPI(url: AppConstants.SERVICE_URL)
    }
    
    func callIngAPI(url: String)
    {
        canadaViewModel.getCanadaDetails(url: url) {(result) in
                if let result = try? result.get()
                {
                    print(result)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = results[indexPath.row].title
        return cell
    }
}

