//
//  DetailViewController.swift
//  To Do List
//
//  Created by Arya Murthi on 9/25/17.
//  Copyright © 2017 Arya Murthi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var toDoField: UITextField!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var toDoNoteView: UITextView!
    
    var toDoItem: String?
    var toDoNoteItem: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let toDoItem = toDoItem {
            toDoField.text = toDoItem
            self.navigationItem.title = "Edit To Do Item"
        } else {
            self.navigationItem.title = "New To Do Item"
        }
        
        if let toDoNoteItem = toDoNoteItem {
            toDoNoteView.text = toDoNoteItem
        }
        
         toDoField.becomeFirstResponder()
        
        //enable disable save button
        if toDoField.text!.count > 0 {
            saveBarButton.isEnabled = true
        }else {
            saveBarButton.isEnabled = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindFromSave" {
            toDoItem = toDoField.text
            toDoNoteItem = toDoNoteView.text
        }
    }
    
    @IBAction func toDoFieldChanged(_ sender: UITextField) {
        if toDoField.text!.count > 0 {
            saveBarButton.isEnabled = true
        }else {
            saveBarButton.isEnabled = false
        }
    }
    
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        }else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    
}
