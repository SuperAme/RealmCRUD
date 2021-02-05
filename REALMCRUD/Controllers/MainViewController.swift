//
//  ViewController.swift
//  REALMCRUD
//
//  Created by IDS Comercial on 2/4/21.
//  Copyright © 2021 Américo MQ. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data = [
        ["americo","matematicas", "10"],
        ["karly","pedagogia", "10"],
        ["bek","IA", "9"]
    ]

    override func viewDidLoad() {
        tableView.dataSource = self
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! InformationTableViewCell
        cell.nameLbl.text = data[indexPath.row][0]
        cell.subjectLbl.text = data[indexPath.row][1]
        cell.scoreLbl.text = data[indexPath.row][2]
        
        return cell
    }
    
    
}

