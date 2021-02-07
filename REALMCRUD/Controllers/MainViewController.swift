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
    var studentsData: Results<Students>?
//    var myStudent = Students()
    
    var data = [
        ["americo","matematicas", "10"],
        ["karly","pedagogia", "10"],
        ["bek","IA", "9"]
    ]

    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        super.viewDidLoad()
        loadData()
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
    
    func loadData() {
        studentsData = realm.objects(Students.self)
        tableView.reloadData()
    }
    func deleteData(index: Int) {
        if let studentToDelete = studentsData?[index] {
            do {
                try realm.write {
                    realm.delete(studentToDelete)
                }
            } catch {
                print("error deleting student: \(error)")
            }
        }
        tableView.reloadData()
    }
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentsData?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! InformationTableViewCell
        cell.nameLbl.text = studentsData?[indexPath.row].name ?? "No students"
        cell.subjectLbl.text = studentsData?[indexPath.row].subject ?? "No subject"
        cell.scoreLbl.text = studentsData?[indexPath.row].score ?? "0"
        
        return cell
    }
}
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (action, view, handler) in
            self.deleteData(index: indexPath.row)
//            print("Delete Action Tapped \(indexPath.row)")
        }
        deleteAction.backgroundColor = .red
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, handler) in
            print("Edit Action Tapped \(indexPath.row)")
        }
        editAction.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        let swipe = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return swipe
    }
}

