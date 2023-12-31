//
//  ToDoListViewController.swift
//  ToDoList
//
//  Created by Badal  Aryal on 28/06/2023.
//

import UIKit

class ToDoListViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet var tableView : UITableView!
    
    var tasks = [String]()//
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Tasks"
        tableView.delegate = self
        tableView.dataSource = self
        
        //setup
        if !UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
            
        }
        
        
        // Get all saved tasks
        updateTasks()
        
        
    }
    func updateTasks(){
        tasks.removeAll()
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        for x in 0..<count{
           if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String{
                tasks.append(task)
            }
        }
        tableView.reloadData()
    }
    
    
    
    
    
    
    
    
    @IBAction func didTapAdd() {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "entry") as! EntryViewController
        vc.title = "New Task"
        vc.update = {
            DispatchQueue.main.async {
                
                self.updateTasks()
            }
            
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ToDoListViewController { //UITableViewDelegate?
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "task") as! TaskViewController
        vc.title = "New Task"
        vc.task = tasks[indexPath.row]
            
        
        navigationController?.pushViewController(vc, animated: true)
    
        
        
    }
}



extension ToDoListViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //dequeue a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]  // indexpath.row represents the position of cell in our table view
        return cell
    }
    
}



