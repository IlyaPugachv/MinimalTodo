import UIKit

extension NewList {
    class Presenter {
        weak var view: View?
        weak var mainPresenter: Main.Presenter?

        init(mainPresenter: Main.Presenter) {
            self.mainPresenter = mainPresenter
        }

        func back() {
            view?.navigationController?.popViewController(animated: true)
        }

        func updateMainView(with newList: TodoList) {
            mainPresenter?.addTodoList(newList)
        }
    }
}
