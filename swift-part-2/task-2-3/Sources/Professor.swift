import Foundation

class Professor: Person {

    nonisolated(unsafe) static var professorCount = 0

    var faculty: String

    var fullTitle: String {
        "Proffessor: \(name), aged \(age), faculty \(faculty)"
    }


    init(name: String, age: Int, faculty: String) {
        self.faculty = faculty
        super.init(name: name, age: age)

        Self.professorCount += 1
    }


    deinit {
        print("deinit professor \(self.profileDescription)")
        Self.professorCount -= 1
    }
}