//
//  File.swift
//  ToDoListSwiftUIFire
//
//  Created by Steve Lai on 2021/7/26.
//

import Foundation

struct Task: Identifiable {
    var id: String = UUID().uuidString
    var title:String
    var completed: Bool
}


#if DEBUG

let testDataTasks = [
    Task(title: "Buy Milk", completed: true),
    Task(title: "學習 iOS", completed: false),
    Task(title: "????", completed: false),
    Task(title: "Get apple before home", completed: false)
]

#endif
