import UIKit

extension Main {
    class Presenter {
        weak var view: View?

        func goToNewListScreen() {
            let newListPresenter = NewList.Presenter(mainPresenter: self)
            let newListView = NewList.View(with: newListPresenter)
            view?.navigationController?.pushViewController(newListView, animated: true)
        }

        func addTodoList(_ todoList: TodoList) {
            view?.addTodoList(todoList)
        }
    }
}
