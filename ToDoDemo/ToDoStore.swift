//
//  ToDosStore.swift
//  ToDoDemo
//
//  Created by Yang Jie on 2021/7/6.
//

import Foundation
import UIKit

class ToDoStore: Store<ToDoStore.Action, ToDoStore.State, ToDoStore.Command> {
    struct State: StateType {
        var dataSource = TableViewControllerDataSource(todos: [], owner: nil)
        var text: String = ""
    }

    enum Action: ActionType {
        case updateText(text: String)
        case addToDos(items: [String])
        case removeToDo(index: Int)
        case loadToDos
    }

    enum Command: CommandType {
        case loadToDos(completion: ([String]) -> Void )
        case someOtherCommand
    }
    
    override func reducer(_ state: State, _ action: Action) -> (State, Command?) {
        var state = state
        var command: Command? = nil
        
        switch action {
        case .updateText(let text):
            state.text = text
        case .addToDos(let items):
            state.dataSource = TableViewControllerDataSource(todos: items + state.dataSource.todos, owner: state.dataSource.owner)
        case .removeToDo(let index):
            let oldTodos = state.dataSource.todos
            state.dataSource = TableViewControllerDataSource(todos: Array(oldTodos[..<index] + oldTodos[(index + 1)...]), owner: state.dataSource.owner)
        case .loadToDos:
            command = Command.loadToDos {
                [weak self] in
                self?.dispatch(.addToDos(items: $0))
            }
        }
        return (state, command)
    }
}
