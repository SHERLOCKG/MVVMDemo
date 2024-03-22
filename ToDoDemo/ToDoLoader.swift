//
//  ToDoStore.swift
//  ToDoDemo
//
//  Created by Yang Jie on 2021/7/6.
//
import Foundation

let dummy = [
    "Buy the milk",
    "Take my dog",
    "Rent a car"
]

struct ToDoLoader {
    static let shared = ToDoLoader()
    func getToDoItems(completionHandler: (([String]) -> Void)?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completionHandler?(dummy)
        }
    }
}
