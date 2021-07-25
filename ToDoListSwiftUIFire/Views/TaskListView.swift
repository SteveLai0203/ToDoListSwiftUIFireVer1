//
//  ContentView.swift
//  ToDoListSwiftUIFire
//
//  Created by Steve Lai on 2021/7/25.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskListVM = TaskListViewModel()
    
    let tasks = testDataTasks
    
    @State var presentAddNewItem = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List{
                    ForEach(taskListVM.taskCellViewModels) { taskCellVM in
                        TaskCell(taskCellVM: taskCellVM)
                    }
                    if presentAddNewItem {
                        TaskCell(taskCellVM: TaskCellViewModel(task: Task(title: "", completed: false))) { task in
                            self.taskListVM.addTask(task: task)
                            self.presentAddNewItem.toggle()
                        }
                    }
                }
                .listStyle(PlainListStyle())
                Button(action: {self.presentAddNewItem.toggle()}){
                    HStack{
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .modifier(ImageModifier())
                        Text("Add New Task")
                    }
                }
                .padding()
            }
            .navigationBarTitle("To Do Lists")
        }
        
    }
}

struct ImageModifier: ViewModifier {
    var size: CGFloat
    
    init(){
        self.size = 20
    }
    
    init(size: CGFloat) {
        self.size = size
    }
    
    func body(content: Content) -> some View {
        content
            .frame(width: size, height: size)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}

struct TaskCell: View {
    @ObservedObject var taskCellVM: TaskCellViewModel
    
    var onCommit: (Task) -> () = {_ in }
    var body: some View {
        HStack{
            Image(systemName: taskCellVM.task.completed ? "checkmark.circle.fill" : "circle")
                .resizable()
                .modifier(ImageModifier())
                .onTapGesture {
                    self.taskCellVM.task.completed.toggle()
                }
            TextField("Enter the task", text: $taskCellVM.task.title, onCommit:{
                self.onCommit(self.taskCellVM.task)
            })
                .padding()
        }
    }
}
