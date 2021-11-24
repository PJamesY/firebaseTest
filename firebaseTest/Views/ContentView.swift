//
//  ContentView.swift
//  firebaseTest
//
//  Created by james on 2021/11/16.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model = ViewModel()
    
    @State var name = ""
    @State var notes = ""
    
    var body: some View {
        
        VStack {
            List(model.list) { item in
                HStack {
                    Text(item.name)
                    Spacer()
                    Button(action: {
                        model.deleteData(todoToDelete: item)
                    }, label: {
                        Image(systemName: "minus.circle")
                    })
                }
                
                
                
            }
            
            Divider()
            
            VStack(spacing: 5) {
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Notes", text: $notes)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    // call add data
                    model.addData(name: name, notes: notes)
                    
                    // clear the text fields
                    name = ""
                    notes = ""
                    
                }, label: {
                    Text("Add Todo Item")
                })
            }
            .padding()
            
        }
        
        
    }
    
    init() {
        model.getData()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
