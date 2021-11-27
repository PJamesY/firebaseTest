//
//  ViewModel.swift
//  firebaseTest
//
//  Created by james on 2021/11/18.
//

import Foundation
import FirebaseFirestore

class ViewModel: ObservableObject {
    @Published var list = [Todo]()
    
    func updateData(todoToUpdate: Todo) {
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Set the data to update
//        db.collection("todos").document(todoToUpdate.)
    }
    
    func deleteData(todoToDelete: Todo) {
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Specify the document to delete
        db.collection("todos").document(todoToDelete.id).delete { error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                // Update the UI from the main thread
                DispatchQueue.main.async {
                    
                    self.list.removeAll { todo in
                        // Check for the todo to remove
                        return todo.id == todoToDelete.id
                    }
                }
                
                
            }
            
        }
    }
    
    func addData(name: String, notes: String) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Add a document to a collection
        db.collection("todos").addDocument(data: ["name": name, "notes": notes]) { error in
            // check for errors
            if error == nil {
                // No errors
                
                // call get data to retrieve latest data
                self.getData()
            }
            else {
                // Handle the error
            }
        }
        
    }
    
    func getData()  {
        // Get ad reference to the database
        let db = Firestore.firestore()
        
        // Read the documents at a specific path
        db.collection("todos").getDocuments { snapshot, error in
            // check for errors
            if error == nil {
                // No errors
                if let snapshot = snapshot {
                    
                    // Update the list property in the main thread
                    DispatchQueue.main.async {
                        // Get all the documents and create Todos
                        self.list = snapshot.documents.map { d in
                            
                            // Create a Todo item for each document returned
                            return Todo(id: d.documentID,
                                        name: d["name"] as? String ?? "",
                                        note: d["notes"] as? String ?? "")
                        }
                    }
                    
                }
            }
            else {
                // Handle the error
            }
        }
        
    }
}
