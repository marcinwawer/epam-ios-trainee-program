import Foundation

struct School {

    var people: [Person] = []

    enum SchoolRole {
        case student, teacher, administrator
    }

    class Person {
        let name: String
        let role: SchoolRole

        init(name: String, role: SchoolRole) {
            self.name = name
            self.role = role
        }
    }

    subscript(role: SchoolRole) -> [Person] {
        people.filter { $0.role == role}
    }

    mutating func addPerson(_ person: Person) {
        if people.contains(where: { $0.name == person.name && $0.role == person.role }) {
            print("Person already registered at school.")
            return
        } else {
            people.append(person)
        }
    }
}

func countStudents(at school: School) -> Int {
    school[.student].count
}

func countTeachers(at school: School) -> Int {
    school[.teacher].count
}

func countAdministrators(at school: School) -> Int {
    school[.administrator].count
}