//
//  ViewController.swift
//  To Do List
//
//  Created by Arya Murthi on 9/25/17.
//  Copyright © 2017 Arya Murthi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    var defaultsData = UserDefaults.standard
    
    var toDoArray = [String]()
    var toDoNotesArray = [String]()
    
    //var toDoArray = ["Learn Swift","Change the World!","Be a better person!"]
    //var toDoNotesArray = ["We doing it right now!","Take your time with this one a lot of people are trying to do it.", "You're already pretty greate so don't stress too much!"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegate allows tableView to send messages to View Controller
        tableView.delegate = self
        
        //dataSource tells tableView it's going to get data from ViewController
        tableView.dataSource = self
        
        toDoArray = defaultsData.stringArray(forKey: "toDoArray") ?? [String]()
        toDoNotesArray = defaultsData.stringArray(forKey: "toDoNotesArray") ?? [String]()
    }
    
    func saveDefaultsData() {
        defaultsData.set(toDoArray, forKey: "toDoArray")
        defaultsData.set(toDoNotesArray, forKey: "toDoNotesArray")
    }
    
    //Pass in to do item String into edit menu for editing after specific row index is clicked
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditItem" {
            let destination = segue.destination as! DetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            destination.toDoItem = toDoArray[index]
            destination.toDoNoteItem = toDoNotesArray[index]
        }else {
            if let selectedPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedPath, animated: false)
            }
        }
    }
    
    @IBAction func unwindFromDetailViewController(segue: UIStoryboardSegue) {
        let sourceViewController = segue.source as! DetailViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            
            toDoArray[indexPath.row] = sourceViewController.toDoItem!
            toDoNotesArray[indexPath.row] = sourceViewController.toDoNoteItem!
            
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }else {
            let newIndexPath = IndexPath(row: toDoArray.count, section: 0)
            
            toDoArray.append(sourceViewController.toDoItem!)
            toDoNotesArray.append(sourceViewController.toDoNoteItem!)
            
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
        saveDefaultsData()
    }
    
    
    @IBAction func editBarButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            addBarButton.isEnabled = true
            editBarButton.title = "Edit"
        }else {
            tableView.setEditing(true, animated: true)
            addBarButton.isEnabled = false
            editBarButton.title = "Done"
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    //Number of rows in total that we have. Data comes from ViewController's toDoArray
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArray.count
    }
    
    //Create a UITableViewCell named cell using the identifier Cell (called on main storyboard)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = toDoArray[indexPath.row]
        cell.detailTextLabel?.text = toDoNotesArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDoArray.remove(at: indexPath.row)
            toDoNotesArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveDefaultsData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = toDoArray[sourceIndexPath.row]
        let noteToMove = toDoNotesArray[sourceIndexPath.row]
        
        toDoArray.remove(at: sourceIndexPath.row)
        toDoNotesArray.remove(at: sourceIndexPath.row)
        
        toDoArray.insert(itemToMove, at: destinationIndexPath.row)
        toDoNotesArray.insert(noteToMove, at: destinationIndexPath.row)
        saveDefaultsData()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
