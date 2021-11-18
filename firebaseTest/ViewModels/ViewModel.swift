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
