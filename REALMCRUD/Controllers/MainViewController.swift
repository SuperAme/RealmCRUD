//
//  ViewController.swift
//  REALMCRUD
//
//  Created by IDS Comercial on 2/4/21.
//  Copyright © 2021 Américo MQ. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var myStudent = Students()
    
    var data = [
        ["americo","matematicas", "10"],
        ["karly","pedagogia", "10"],
        ["bek","IA", "9"]
    ]

    override func viewDidLoad() {
        tableView.dataSource = self
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Register Users", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(cancelAction)
        
        let registerAction = UIAlertAction(title: "Register", style: .default) { (action) in
            let newStudent = Students()
            let name = alertController.textFields![0] as UITextField
            let subject = alertController.textFields![1] as UITextField
            let score = alertController.textFields![2] as UITextField
            
            if name.text != "" && subject.text != "" && score.text != "" {
                newStudent.name = name.text!
                newStudent.subject = subject.text!
                newStudent.score = score.text!
                self.saveData(student: newStudent)
            }
            
            
        }
        
        alertController.addAction(registerAction)
        alertController.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Subject"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Score"
        }
        present(alertController, animated: true, completion: nil)
    }
    
    func saveData(student: Students) {
        do {
            try realm.write {
                realm.add(student)
            }
        } catch {
            print("erros saving data \(error)")
        }
        tableView.reloadData()
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

