//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Tarun on 24/06/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
//    @Query(sort: \User.name) var users: [User]
    
    //MARK: updating querying sort by adding predicate.
//    @Query(filter: #Predicate<User> { user in
//        user.name.localizedStandardContains("r")  && // it becomes not case sensitive
//        user.city == "Dwaraka"
//    },sort: \User.name) var users: [User] // this will sort according to the name and the user.name which contains "r".
    
    //MARK: updating the querying
//    @Query( filter: #Predicate<User> { user in
//        if user.name.localizedStandardContains("r") {
//            if user.city == "Dwaraka" {
//                return true
//            }else{
//                return false
//            }
//        }else{
//            return false
//        }
//    },sort: \User.name) var users: [User]
    
    //MARK: Dynamically sorting and filtering
    @State private var showingUpComingOnly = false
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate)
    ]
    
    var body: some View {
        NavigationStack{
//            List(users) { user in
//                Text(user.name)
//            }
            UsersView(minimumJoinDate: showingUpComingOnly ? .now : .distantPast, sortOrder: sortOrder)
            .navigationTitle("Users")
            .toolbar {
                Button("Add Samples", systemImage: "plus"){
//                    let user = User(name: "", city: "", joinDate: .now)
//                    modelContext.insert(user)
//                    path = [user]
                    
                    //Addding bulk number of users.
                    try? modelContext.delete(model: User.self)
                    
                    let first = User(name: "Krishna", city: "Dwaraka", joinDate: .now.addingTimeInterval(84600 * -10))
                    let second = User(name: "Narasimha", city: "Simhachalam", joinDate: .now.addingTimeInterval(84600 * -5))
                    let third = User(name: "Kurma", city: "Arunachalam", joinDate: .now.addingTimeInterval(84600 * 5))
                    let forth = User(name: "Vamana", city: "srikalahasti", joinDate: .now.addingTimeInterval(84600 * -5))
                    
                    modelContext.insert(first)
                    modelContext.insert(second)
                    modelContext.insert(third)
                    modelContext.insert(forth)
                    
                }
                
                Button(showingUpComingOnly ? "Show Everyone" : "Show Upcoming") {
                    showingUpComingOnly.toggle()
                }
                
                Menu("Sort", systemImage: "arrow.up.arrow.down"){
                    Picker("Sort", selection: $sortOrder){
                        Text("Sort by name")
                            .tag([
                                SortDescriptor(\User.name),
                                SortDescriptor(\User.joinDate)
                            ])
                        
                        Text("Sort by Join Date")
                            .tag([
                                SortDescriptor(\User.joinDate),
                                SortDescriptor(\User.name)
                            ])
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
